"""Print moves of a G-code layer laid on the slice raster.

Each print move is drawn as a bead of its own width on a raster of SUBPIXELS x SUBPIXELS
pixels per 0.1 mm cell. A pixel gains a pass each time the bead comes over it again (the
next line of a serpentine, another bead crossing it), not along one continuous stretch.

The width of a move is the volume-equivalent width A / h of its extruded cross-section A
(filament length x filament area / move length). Callers add ROUNDING_MM to get the nominal
bead width w = A / h + h (1 - pi / 4) of PrusaSlicer's flow model.

Coordinates: cell (row i, column j) of an image with `rows` rows is at
X = j * CELL_MM, Y = (rows - 1 - i) * CELL_MM, as the G-code was written.
"""

import math

import numpy as np
from numba import njit

from config import CELL_MM, FILAMENT_MM, LAYER_HEIGHT_MM
from gcode import EXTRUDE_MM, parse

SUBPIXELS = 4
SAMPLE_PX = 0.5                  # Spacing of the samples along a move, in pixels.
GAP_SAMPLES = 2                  # A pixel left for more samples than this gets a new pass when revisited.
MARGIN_MM = 1.0
FILAMENT_AREA = math.pi * (FILAMENT_MM / 2) ** 2


def extrusion_segments(lines):
    """(n, 6) array of the print moves: x0, y0, x1, y1, width (mm), bead number."""
    rows, bead, in_bead = [], -1, False
    for cmd in parse(lines):
        if cmd["E_increment"] > EXTRUDE_MM and cmd["dist"] > 0:
            if not in_bead:
                bead, in_bead = bead + 1, True
            area = cmd["E_increment"] * FILAMENT_AREA / cmd["dist"]
            rows.append((cmd["start"][0], cmd["start"][1], cmd["X"], cmd["Y"], area / LAYER_HEIGHT_MM, bead))
        elif cmd["dist"] > 0 or cmd["is_retraction"]:
            in_bead = False
    return np.array(rows, dtype=float).reshape(-1, 6)


def mean_width(segments):
    """Length-weighted mean width of the print moves."""
    if not len(segments):
        return math.nan
    lengths = np.hypot(segments[:, 2] - segments[:, 0], segments[:, 3] - segments[:, 1])
    total = float(lengths.sum())
    return float((segments[:, 4] * lengths).sum() / total) if total else math.nan


@njit(cache=True)
def _count_passes(px, py, pr, pidx, ny, nx, gap):
    passes = np.zeros((ny, nx), np.uint16)
    last = np.full((ny, nx), -(1 << 40), np.int64)
    for k in range(px.shape[0]):
        cx, cy, r = px[k], py[k], pr[k]
        r2, idx = r * r, pidx[k]
        i0, i1 = max(int(math.floor(cy - r)), 0), min(int(math.ceil(cy + r)), ny - 1)
        j0, j1 = max(int(math.floor(cx - r)), 0), min(int(math.ceil(cx + r)), nx - 1)
        for i in range(i0, i1 + 1):
            dy2 = (i - cy) * (i - cy)
            if dy2 > r2:
                continue
            for j in range(j0, j1 + 1):
                if dy2 + (j - cx) * (j - cx) <= r2:
                    if idx - last[i, j] > gap:
                        passes[i, j] += 1
                    last[i, j] = idx
    return passes


class Raster:
    """Subpixel raster of a slice mask with a margin around it."""

    def __init__(self, mask, cell_mm=CELL_MM, subpixels=SUBPIXELS, margin_mm=MARGIN_MM):
        self.s, self.cell = subpixels, cell_mm
        self.px_mm = cell_mm / subpixels
        self.m = int(math.ceil(margin_mm / self.px_mm))
        h, w = mask.shape
        self.rows = h
        self.ny, self.nx = h * subpixels + 2 * self.m, w * subpixels + 2 * self.m
        self.part = np.zeros((self.ny, self.nx), dtype=bool)
        self.part[self.m:self.m + h * subpixels, self.m:self.m + w * subpixels] = \
            np.repeat(np.repeat(np.asarray(mask, dtype=bool), subpixels, 0), subpixels, 1)

    def to_px(self, mm):
        return (mm + self.cell / 2.0) / self.px_mm + self.m - 0.5

    def to_px_y(self, mm):
        return self.to_px((self.rows - 1) * self.cell - mm)

    def passes(self, segments):
        """Number of passes over every pixel."""
        if not len(segments):
            return np.zeros((self.ny, self.nx), np.uint16)
        xs, ys, rs, idx = [], [], [], []
        k, prev_bead = 0, -1
        for x0, y0, x1, y1, width, bead in segments:
            a = np.array([self.to_px(x0), self.to_px_y(y0)])
            b = np.array([self.to_px(x1), self.to_px_y(y1)])
            n = max(int(math.ceil(np.hypot(*(b - a)) / SAMPLE_PX)), 1)
            if bead != prev_bead:
                t = np.linspace(0.0, 1.0, n + 1)
                k += GAP_SAMPLES + 2
                prev_bead = bead
            else:
                t = np.linspace(0.0, 1.0, n + 1)[1:]
            pts = a + t[:, None] * (b - a)
            xs.append(pts[:, 0])
            ys.append(pts[:, 1])
            rs.append(np.full(len(t), width / 2.0 / self.px_mm))
            idx.append(np.arange(k, k + len(t)))
            k += len(t)
        return _count_passes(np.concatenate(xs), np.concatenate(ys), np.concatenate(rs),
                             np.concatenate(idx).astype(np.int64), self.ny, self.nx, GAP_SAMPLES)

    def cell_share(self, pixels):
        """Share of each cell of the slice that a pixel map covers."""
        n, w, s, m = self.rows, (self.nx - 2 * self.m) // self.s, self.s, self.m
        return pixels[m:m + n * s, m:m + w * s].reshape(n, s, w, s).mean(axis=(1, 3))
