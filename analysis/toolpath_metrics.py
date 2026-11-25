"""Time, continuity, kinematics and geometry metrics of one G-code layer on its slice.

  print_time_s               trapezoidal speed profile at the common feed rates, no slowdown at corners
  print_time_junction_s      lookahead planner that also slows down at corners (classic jerk JERK_MM_S
                             per axis, as the MK4 profile); the head stops at retractions and Z moves
  travel_mm, extruded_mm, retractions, extrusion_starts (beads), mean_bead_mm,
  lcf                        longest bead / extruded length
  unretracted_travels, unretracted_travel_mm   travels between two beads with no retraction
  direction_changes_per_10mm turns above TURN_DEG within a bead, after joining collinear moves
  sharp_turn_share           share of those turns above 90 degrees
  mean_straight_mm           extruded length / straight runs
  contour_alignment          mean |cos| between the bead direction and the slice outline tangent, for
                             bead points within 2 bead widths of the outline (1: beads follow it)
  orientation_entropy        entropy of the bead directions in 15 degree bins, / ln 12
  islands, travel_lb_mm      8-connected islands and the shortest travel between them (minimum
                             spanning tree of the gaps between their outlines)
  excess_travel_mm, starts_per_island
"""

import math

import numpy as np
from numba import njit
from scipy.ndimage import binary_erosion, distance_transform_edt, gaussian_filter, label
from scipy.sparse.csgraph import minimum_spanning_tree
from scipy.spatial import cKDTree

import gcode as G
from config import CELL_MM
from deposition import Raster, extrusion_segments, mean_width

TURN_DEG = 5.0
SHARP_DEG = 90.0
ORIENT_BINS = 12
NEAR_BOUNDARY_WIDTHS = 2.0
TANGENT_SIGMA_CELLS = 1.0
ALIGN_SAMPLE_PX = 2.0
JERK_MM_S = 8.0                  # MK4IS profile machine_max_jerk_x/y.
COLLINEAR_TOL = 1e-3
EIGHT = np.ones((3, 3), dtype=bool)


class Slice:
    """Raster, outline tangents and island lower bounds of a slice, shared by all its toolpaths."""

    def __init__(self, mask):
        self.mask = np.asarray(mask, dtype=bool)
        self.raster = r = Raster(self.mask)
        self.T = r.part
        self.px_mm = r.px_mm
        sdf = (distance_transform_edt(self.T) - distance_transform_edt(~self.T)).astype(np.float32)
        g_row, g_col = np.gradient(gaussian_filter(sdf, TANGENT_SIGMA_CELLS * r.s))
        norm = np.hypot(g_row, g_col)
        norm[norm == 0] = 1.0
        self.tangent_col, self.tangent_row = (-g_row / norm).astype(np.float32), (g_col / norm).astype(np.float32)
        self.dist_to_edge = np.abs(sdf) * self.px_mm
        self.islands, self.travel_lb_mm = island_travel(self.mask)


def island_travel(mask, cell_mm=CELL_MM):
    labels, k = label(mask, structure=EIGHT)
    travel = 0.0
    if k > 1:
        outline = mask & ~binary_erosion(mask, EIGHT)
        trees = [cKDTree(np.argwhere(outline & (labels == i + 1))) for i in range(k)]
        gaps = np.zeros((k, k))
        for i in range(k):
            for j in range(i + 1, k):
                d, _ = trees[j].query(trees[i].data, k=1)
                gaps[i, j] = gaps[j, i] = max(float(d.min()), 1e-9)
        travel = float(minimum_spanning_tree(gaps).sum()) * cell_mm
    return int(k), travel


def unretracted_travels(commands):
    runs = unretracted = 0
    run_mm = unretracted_mm = 0.0
    seen_bead = retracted = False
    for cmd in commands:
        if cmd["E_increment"] > G.EXTRUDE_MM and cmd["dist"] > 0:
            if seen_bead and run_mm > 0:
                runs += 1
                if not retracted:
                    unretracted += 1
                    unretracted_mm += run_mm
            seen_bead, retracted, run_mm = True, False, 0.0
            continue
        if cmd["is_retraction"]:
            retracted = True
        if seen_bead and cmd["dist"] > 0:
            run_mm += cmd["dist"]
    return {"unretracted_travels": unretracted, "unretracted_travel_mm": unretracted_mm}


def merged_segments(segments):
    """Print moves with consecutive collinear moves of the same bead joined."""
    out = []
    for x0, y0, x1, y1, w, bead in segments:
        if math.hypot(x1 - x0, y1 - y0) < 1e-9:
            continue
        if out and out[-1][5] == bead and abs(out[-1][2] - x0) < 1e-9 and abs(out[-1][3] - y0) < 1e-9:
            px0, py0, px1, py1 = out[-1][:4]
            ax, ay, bx, by = px1 - px0, py1 - py0, x1 - x0, y1 - y0
            la, lb = math.hypot(ax, ay), math.hypot(bx, by)
            if abs(ax * by - ay * bx) <= COLLINEAR_TOL * la * lb and ax * bx + ay * by > 0:
                out[-1] = [px0, py0, x1, y1, w, bead]
                continue
        out.append([x0, y0, x1, y1, w, bead])
    return np.array(out, dtype=float).reshape(-1, 6)


@njit(cache=True)
def _planned_time(length, speed, jx, jy, stop_before, accel, jerk):
    """Lookahead planner: junction speeds limited by the jerk per axis, then backward and forward passes."""
    n = length.shape[0]
    vj = np.zeros(n + 1)
    for i in range(n):
        v = speed[i]
        if i == 0 or stop_before[i]:
            for c in (abs(jx[i]), abs(jy[i])):
                if c > 1e-12:
                    v = min(v, jerk / c)
        else:
            v = min(v, speed[i - 1])
            for c in (abs(jx[i] - jx[i - 1]), abs(jy[i] - jy[i - 1])):
                if c > 1e-12:
                    v = min(v, jerk / c)
        vj[i] = v
    end = speed[n - 1]
    for c in (abs(jx[n - 1]), abs(jy[n - 1])):
        if c > 1e-12:
            end = min(end, jerk / c)
    vj[n] = end
    for i in range(n - 1, -1, -1):
        vj[i] = min(vj[i], math.sqrt(vj[i + 1] ** 2 + 2 * accel * length[i]))
    for i in range(n):
        vj[i + 1] = min(vj[i + 1], math.sqrt(vj[i] ** 2 + 2 * accel * length[i]))
    total = 0.0
    for i in range(n):
        v0, v1, v, L = vj[i], vj[i + 1], speed[i], length[i]
        d_acc, d_dec = (v * v - v0 * v0) / (2 * accel), (v * v - v1 * v1) / (2 * accel)
        if d_acc + d_dec <= L:
            total += (v - v0) / accel + (v - v1) / accel + (L - d_acc - d_dec) / v
        else:
            vp = math.sqrt((2 * accel * L + v0 * v0 + v1 * v1) / 2)
            total += (vp - v0) / accel + (vp - v1) / accel
    return total


def junction_time(commands, v_print, v_travel, accel, jerk=JERK_MM_S):
    length, speed, dirs, stop = [], [], [], []
    pending_stop = True
    for cmd in commands:
        if cmd["dist"] <= 0:
            if cmd["start"] is not None:
                pending_stop = True               # Retract, unretract or Z move: the head stops.
            continue
        dx, dy = cmd["X"] - cmd["start"][0], cmd["Y"] - cmd["start"][1]
        length.append(cmd["dist"])
        speed.append(v_print if cmd["E_increment"] > G.EXTRUDE_MM else v_travel)
        dirs.append((dx / cmd["dist"], dy / cmd["dist"]))
        stop.append(pending_stop)
        pending_stop = False
    if not length:
        return 0.0
    d = np.array(dirs)
    return float(_planned_time(np.array(length), np.array(speed), d[:, 0], d[:, 1], np.array(stop),
                               float(accel), float(jerk)))


def kinematics(segments):
    merged = merged_segments(segments)
    if not len(merged):
        return {"direction_changes_per_10mm": math.nan, "sharp_turn_share": math.nan, "mean_straight_mm": math.nan}
    vec = merged[:, 2:4] - merged[:, 0:2]
    L = np.hypot(vec[:, 0], vec[:, 1])
    u = vec / L[:, None]
    same_bead = merged[1:, 5] == merged[:-1, 5]
    angle = np.degrees(np.arccos(np.clip((u[1:] * u[:-1]).sum(axis=1), -1.0, 1.0)))[same_bead]
    turns = angle > TURN_DEG
    L_E = float(L.sum())
    beads = int(len(np.unique(merged[:, 5])))
    return {"direction_changes_per_10mm": 10.0 * turns.sum() / L_E,
            "sharp_turn_share": float((angle > SHARP_DEG).sum() / turns.sum()) if turns.any() else math.nan,
            "mean_straight_mm": L_E / (beads + int(turns.sum()))}


def orientation(segments, s, width_mm):
    """Orientation entropy and contour alignment of the print moves."""
    out = {"contour_alignment": math.nan, "orientation_entropy": math.nan}
    if not len(segments):
        return out
    dx, dy = segments[:, 2] - segments[:, 0], segments[:, 3] - segments[:, 1]
    L = np.hypot(dx, dy)
    keep = L > 1e-9
    dx, dy, L, seg = dx[keep], dy[keep], L[keep], segments[keep]

    theta = np.mod(np.arctan2(dy, dx), np.pi)
    bins = np.floor(theta / np.pi * ORIENT_BINS + 0.5).astype(int) % ORIENT_BINS    # Bins centred on 0, 15, ... 165 deg.
    hist = np.bincount(bins, weights=L, minlength=ORIENT_BINS) / L.sum()
    p = hist[hist > 0]
    out["orientation_entropy"] = float(-(p * np.log(p)).sum() / math.log(ORIENT_BINS))

    r = s.raster
    c0, r0 = r.to_px(seg[:, 0]), r.to_px_y(seg[:, 1])
    c1, r1 = r.to_px(seg[:, 2]), r.to_px_y(seg[:, 3])
    n = np.maximum(np.ceil(np.hypot(c1 - c0, r1 - r0) / ALIGN_SAMPLE_PX).astype(int), 1)
    t = (np.concatenate([np.arange(k) for k in n]) + 0.5) / np.repeat(n, n)
    cc = np.repeat(c0, n) + t * np.repeat(c1 - c0, n)
    rr = np.repeat(r0, n) + t * np.repeat(r1 - r0, n)
    w = np.repeat(L / n, n)
    dc, dr = np.repeat(dx / L, n), np.repeat(-dy / L, n)        # Pixel rows run down.
    ri = np.clip(np.rint(rr).astype(int), 0, r.ny - 1)
    ci = np.clip(np.rint(cc).astype(int), 0, r.nx - 1)
    align = np.abs(dc * s.tangent_col[ri, ci] + dr * s.tangent_row[ri, ci])
    near = s.dist_to_edge[ri, ci] <= NEAR_BOUNDARY_WIDTHS * width_mm
    if near.any():
        out["contour_alignment"] = float((align * w)[near].sum() / w[near].sum())
    return out


def toolpath_metrics(lines, s, machine):
    """Metrics of one layer: `lines` its main path, `s` the Slice, `machine` the timing settings."""
    commands = G.parse(lines)
    out = G.analyze(commands, machine)
    segments = extrusion_segments(lines)
    width = mean_width(segments)
    v_print, v_travel = machine["force_print_feedrate"] / 60.0, machine["force_travel_feedrate"] / 60.0
    out["print_time_junction_s"] = junction_time(commands, v_print, v_travel, machine["max_acceleration"])
    out.update(unretracted_travels(commands))
    out.update(kinematics(segments))
    out.update(orientation(segments, s, width if width == width else 0.4))
    out.update({"islands": s.islands, "travel_lb_mm": s.travel_lb_mm,
                "excess_travel_mm": out["travel_mm"] - s.travel_lb_mm,
                "starts_per_island": out["extrusion_starts"] / s.islands})
    return out
