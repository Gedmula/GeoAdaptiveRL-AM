"""Part quality of a G-code layer from the bead swept along the print path.

Each print move is a capsule: the segment buffered by half its nominal width
w = A / h + h (1 - pi / 4) with round ends. B is the union of the capsules and T the exact
union of the slice cells (0.1 mm squares). All areas are computed on polygons (shapely).

  fill_pct              area(B n T) / area(T)
  overspill_pct         area(B \\ T) / area(T)
  over_deposition_pct   area under two or more passes / area(B). A second pass is a capsule of
                        another bead, or of the same bead at least one bead width further along it.
  dice                  2 area(B n T) / (area(B) + area(T))
  void_count, void_per_cm2, void_largest_mm2   parts of T \\ B larger than VOID_MIN_MM2
  edge_fill_pct         area(B n E) / area(E), E the boundary cells of the slice (4-neighbour)
"""

import math

import numpy as np
import shapely
import shapely.affinity
from shapely.geometry import box

from config import CELL_MM, ROUNDING_MM
from deposition import extrusion_segments

QUAD_SEGS = 8                    # Arc resolution of the capsule ends, per quarter circle.
VOID_MIN_MM2 = 1e-4              # Smaller parts of T \ B are numerical slivers.


def cells_polygon(mask, cell=CELL_MM):
    """Exact union of the True cells of a mask, built from row runs."""
    mask = np.asarray(mask, dtype=bool)
    rows = mask.shape[0]
    boxes = []
    for i in range(rows):
        r = np.concatenate(([0], mask[i].view(np.int8), [0]))
        d = np.diff(r)
        starts, ends = np.flatnonzero(d == 1), np.flatnonzero(d == -1)
        y = rows - 1 - i
        for j0, j1 in zip(starts, ends):
            boxes.append(box(2 * j0 - 1, 2 * y - 1, 2 * j1 - 1, 2 * y + 1))     # Half-cell units.
    if not boxes:
        return shapely.Polygon()
    u = shapely.unary_union(boxes)
    return shapely.affinity.scale(u, xfact=cell / 2, yfact=cell / 2, origin=(0, 0))


def capsules(seg):
    lines = shapely.linestrings(np.stack([seg[:, [0, 1]], seg[:, [2, 3]]], axis=1))
    return shapely.buffer(lines, seg[:, 4] / 2.0, quad_segs=QUAD_SEGS, cap_style="round")


def multi_pass_region(caps, seg):
    if len(caps) < 2:
        return shapely.Polygon()
    length = np.hypot(seg[:, 2] - seg[:, 0], seg[:, 3] - seg[:, 1])
    s_end = np.cumsum(length)
    s_start = s_end - length
    a, b = shapely.STRtree(caps).query(caps, predicate="intersects")
    keep = a < b
    a, b = a[keep], b[keep]
    same = seg[a, 5] == seg[b, 5]
    gap = s_start[b] - s_end[a]                  # Path length between two moves of the same bead.
    near = same & (gap < np.maximum(seg[a, 4], seg[b, 4]))
    a, b = a[~near], b[~near]
    if not len(a):
        return shapely.Polygon()
    return shapely.unary_union(shapely.intersection(caps[a], caps[b]))


def boundary_cells(mask):
    inner = mask.copy()
    inner[1:, :] &= mask[:-1, :]; inner[:-1, :] &= mask[1:, :]
    inner[:, 1:] &= mask[:, :-1]; inner[:, :-1] &= mask[:, 1:]
    return mask & ~inner


def sweep_quality(lines, mask, with_overlap=True, return_geometry=False):
    """Quality metrics of a layer; with return_geometry also the regions B, T and E (shapely)."""
    mask = np.asarray(mask, dtype=bool)
    T = cells_polygon(mask)
    aT = T.area
    seg = extrusion_segments(lines)
    if not len(seg) or aT == 0:
        return {"fill_pct": 0.0}
    seg[:, 4] = seg[:, 4] + ROUNDING_MM
    caps = capsules(seg)
    B = shapely.unary_union(caps)
    BT = shapely.intersection(B, T)
    out = {"fill_pct": 100.0 * BT.area / aT,
           "overspill_pct": 100.0 * shapely.difference(B, T).area / aT,
           "dice": 2.0 * BT.area / (B.area + aT),
           "line_width_mm": float(np.median(seg[:, 4]))}
    if with_overlap:
        O = multi_pass_region(caps, seg)
        out["over_deposition_pct"] = 100.0 * O.area / B.area if B.area else math.nan
    V = shapely.difference(T, B)
    parts = [g.area for g in getattr(V, "geoms", [V]) if not g.is_empty and g.area > VOID_MIN_MM2]
    out.update({"void_count": len(parts), "void_per_cm2": len(parts) / (aT / 100.0),
                "void_largest_mm2": max(parts) if parts else 0.0})
    E = cells_polygon(boundary_cells(mask))
    out["edge_fill_pct"] = 100.0 * shapely.intersection(B, E).area / E.area if E.area else math.nan
    if return_geometry:
        out.update({"B": B, "T": T, "E": E})
    return out
