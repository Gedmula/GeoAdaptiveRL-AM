"""Per-layer metrics of RL and the five solid PrusaSlicer patterns on the 500x500 test layers.

Every toolpath is measured from its G-code in the same way. Part quality is computed twice:
  per_slice_metrics.csv          bead sweep (bead_sweep.py)
  per_slice_metrics_raster.csv   raster of 4 x 4 subpixels per cell; a cell is filled when at
                                 least half of it is covered, over-deposited when at least
                                 half of it lies under two or more passes
time_lb_s is a lower bound of the print time: slice area / 0.45 mm at the print speed.

    python analysis/evaluate_toolpaths.py
"""

import json
import os
import time
from multiprocessing import Pool

import numpy as np
import pandas as pd
from scipy.ndimage import label

import config as C
from bead_sweep import QUAD_SEGS, VOID_MIN_MM2, sweep_quality
from deposition import extrusion_segments
from gcode import main_path, read_gcode_file
from layers import manifest, read_mask
from toolpath_metrics import EIGHT, Slice, toolpath_metrics

LIMIT = None                     # Layers of the manifest to evaluate; None: all.
FILLED_SHARE = 0.5
QUALITY = ("fill_pct", "overspill_pct", "over_deposition_pct", "dice", "void_count", "void_per_cm2",
           "void_largest_mm2", "edge_fill_pct", "line_width_mm")
KEEP = ("print_time_s", "print_time_junction_s", "travel_mm", "extruded_mm", "extrusion_starts", "retractions",
        "unretracted_travels", "unretracted_travel_mm", "mean_bead_mm", "lcf", "direction_changes_per_10mm",
        "sharp_turn_share", "mean_straight_mm", "islands", "travel_lb_mm", "excess_travel_mm", "starts_per_island",
        "contour_alignment", "orientation_entropy")


def raster_quality(lines, s):
    seg = extrusion_segments(lines)
    mask = s.mask
    if not len(seg):
        return {"fill_pct": 0.0}
    seg[:, 4] = seg[:, 4] + C.ROUNDING_MM
    passes = s.raster.passes(seg)
    filled = s.raster.cell_share(passes > 0) >= FILLED_SHARE
    over = s.raster.cell_share(passes >= 2) >= FILLED_SHARE
    T = int(mask.sum())
    lab, k = label(mask & ~filled, structure=EIGHT)
    sizes = np.bincount(lab.ravel())[1:] if k else np.zeros(0)
    inner = mask.copy()
    inner[1:, :] &= mask[:-1, :]; inner[:-1, :] &= mask[1:, :]; inner[:, 1:] &= mask[:, :-1]; inner[:, :-1] &= mask[:, 1:]
    edge = mask & ~inner
    return {"fill_pct": 100.0 * (filled & mask).sum() / T,
            "overspill_pct": 100.0 * (filled & ~mask).sum() / T,
            "over_deposition_pct": 100.0 * (over & filled).sum() / max(int(filled.sum()), 1),
            "dice": 2.0 * (filled & mask).sum() / (filled.sum() + T),
            "void_count": int(k), "void_per_cm2": k / (T * 0.01 / 100.0),
            "void_largest_mm2": float(sizes.max()) * 0.01 if k else 0.0,
            "edge_fill_pct": 100.0 * (filled & edge).sum() / max(int(edge.sum()), 1),
            "line_width_mm": float(np.median(seg[:, 4]))}


def evaluate(task):
    mask = read_mask(task["image"])
    s = Slice(mask)
    rows = []
    for tp, group, path in task["toolpaths"]:
        row = {k: task[k] for k in ("layer", "class", "complexity_ratio", "area_mm2")}
        row.update(toolpath=tp, group=group, gcode=os.path.relpath(path, C.ROOT).replace(os.sep, "/"))
        if not os.path.exists(path):
            rows.append(({**row, "status": "missing"}, {}))
            continue
        try:
            lines = main_path(read_gcode_file(path))
            row.update({k: v for k, v in toolpath_metrics(lines, s, C.MACHINE).items() if k in KEEP})
            raster = raster_quality(lines, s)
            sweep = sweep_quality(lines, mask)
            row["time_lb_s"] = (mask.sum() * 0.01 / C.LINE_MM) / (C.MACHINE["force_print_feedrate"] / 60.0)
            row["status"] = "ok"
            rows.append(({**row, **raster}, sweep))
        except Exception as err:
            rows.append(({**row, "status": "failed", "error": f"{type(err).__name__}: {err}"}, {}))
    return rows


def tasks(limit=None):
    folder = C.test_folder(C.COMPARISON_SIZE)
    man = manifest(folder)
    out = []
    for _, r in man.iterrows():
        sub, name = r["subfolder"], r["layer"]
        tps = [("RL", "RL", os.path.join(C.RL_GCODE, C.grid(C.COMPARISON_SIZE), sub, f"{name}.gcode"))]
        tps += [(p, "solid", os.path.join(C.BASELINE_GCODE, p, sub, f"{name}_{p}.gcode")) for p in C.SOLID]
        out.append({"layer": name, "class": r["complexity_class"], "complexity_ratio": r["complexity_ratio"],
                    "area_mm2": r["area_mm2"], "image": os.path.join(folder, r["file"]), "toolpaths": tps})
    return out[:limit] if limit else out


COLUMNS = ["layer", "class", "complexity_ratio", "area_mm2", "toolpath", "group", "gcode", *KEEP, *QUALITY,
           "time_lb_s", "status"]


def table(rows):
    df = pd.DataFrame(rows)
    return df[[c for c in COLUMNS if c in df] + [c for c in df if c not in COLUMNS]]


if __name__ == "__main__":
    t0, todo, raster_rows, sweep_rows = time.time(), tasks(LIMIT), [], []
    print(f"{len(todo)} layers x {1 + len(C.SOLID)} toolpaths, {C.WORKERS} workers", flush=True)
    with Pool(C.WORKERS) as pool:
        for k, rows in enumerate(pool.imap(evaluate, todo), 1):
            for row, sweep in rows:
                raster_rows.append(row)
                sweep_rows.append({**row, **{q: sweep.get(q, np.nan) for q in QUALITY}} if row["status"] == "ok" else row)
            if k % 20 == 0 or k == len(todo):
                print(f"  [{time.time() - t0:.0f} s] {k}/{len(todo)}", flush=True)
    table(raster_rows).to_csv(C.output("baseline_comparison", "per_slice_metrics_raster.csv"), index=False)
    df = table(sweep_rows)
    df.to_csv(C.output("baseline_comparison", "per_slice_metrics.csv"), index=False)
    with open(C.output("baseline_comparison", "settings.json"), "w") as f:
        json.dump({"machine": C.MACHINE, "line_mm": C.LINE_MM, "filled_share": FILLED_SHARE,
                   "rounding_mm": C.ROUNDING_MM, "quad_segs": QUAD_SEGS, "void_min_mm2": VOID_MIN_MM2,
                   "status": df.status.value_counts().to_dict(), "seconds": round(time.time() - t0)}, f, indent=1)
    print(df.groupby("toolpath")["status"].value_counts().to_string())
