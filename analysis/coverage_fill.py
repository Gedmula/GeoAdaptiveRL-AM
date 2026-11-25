"""Coverage reported by the environment against the fill of the printed G-code, on every test set.

The environment counts a cell as covered when the deposition kernel (0.45 mm bead) has put
enough material on it. The fill is measured on the RL G-code (0.45 mm line):
  coverage_fill_raw.csv, coverage_fill_raster.csv   raster method: a cell is filled when at least
      half of it is covered; fill_subpx_pct is the covered share on the subpixel raster
  coverage_fill.csv   bead sweep (bead_sweep.py) for fill_pct and overspill_pct, as in the article
  summary.csv         agreement of the bead-sweep fill with the coverage per grid size and class
                      (fill - coverage: median, IQR, bias, 95 % limits of agreement, share within
                      1 and 3 pp)
env_overspill_pct is the environment's spilled cells as % of the slice.

    python analysis/coverage_fill.py

With REGENERATE_GCODE the G-code is first written from the path JSONs (path_to_gcode.py) into
results/reproduced/gcode_rl/ and those files are measured instead of gcode/rl_test_layers/.
"""

import glob
import json
import math
import os
from multiprocessing import Pool
from pathlib import Path

import numpy as np
import pandas as pd

import config as C
from bead_sweep import sweep_quality
from deposition import Raster, extrusion_segments
from gcode import main_path, read_gcode_file
from layers import manifest, read_mask, shape_metrics
from path_to_gcode import json_to_gcode

REGENERATE_GCODE = False
FILLED_SHARE = 0.5


def measure(task):
    size, js, image, gcode, regenerate = task
    if regenerate:
        os.makedirs(os.path.dirname(gcode), exist_ok=True)
        json_to_gcode(js, gcode)
    with open(js) as f:
        pm = json.load(f)["performance_metrics"]
    mask = read_mask(image)
    lines = main_path(read_gcode_file(gcode))
    seg = extrusion_segments(lines)
    seg[:, 4] = seg[:, 4] + C.ROUNDING_MM
    ras = Raster(mask)
    covered = ras.passes(seg) > 0
    filled = ras.cell_share(covered) >= FILLED_SHARE
    target = int(mask.sum())
    raw = {"size": size, "layer": Path(js).name.replace("_path.json", ""), "outcome": pm.get("outcome"),
           "coverage_pct": 100.0 * pm["coverage"],
           "fill_pct": 100.0 * float((filled & mask).sum()) / target,
           "fill_subpx_pct": 100.0 * float((covered & ras.part).sum()) / float(ras.part.sum()),
           "env_overspill_pct": 100.0 * pm.get("spilled_cells", math.nan) / target,
           "overspill_pct": 100.0 * float((filled & ~mask).sum()) / target,
           "line_width_mm": float(np.median(seg[:, 4])) if len(seg) else math.nan,
           "target_cells": target}
    sweep = sweep_quality(lines, mask, with_overlap=False)
    return raw, {"fill_pct": sweep.get("fill_pct", math.nan), "overspill_pct": sweep.get("overspill_pct", math.nan)}


def tasks(regenerate):
    out = []
    for size in C.TEST_SIZES:
        folder = C.test_folder(size)
        files = dict(zip(manifest(folder)["layer"], manifest(folder)["file"]))
        raw = os.path.join(C.RAW, C.grid(size))
        for js in sorted(glob.glob(f"{raw}/*/json/*_path.json") + glob.glob(f"{raw}/json/*_path.json")):
            name = Path(js).name.replace("_path.json", "")
            sub = os.path.relpath(os.path.dirname(os.path.dirname(js)), raw)
            base = os.path.join(C.REPRODUCED, "gcode_rl") if regenerate else C.RL_GCODE
            gcode = os.path.normpath(os.path.join(base, C.grid(size), sub, f"{name}.gcode"))
            out.append((size, js, os.path.join(folder, files[name]), gcode, regenerate))
    return out


def layer_info(size):
    """Class, complexity ratio and area of every test layer, from the slice where the manifest lacks them."""
    folder = C.test_folder(size)
    m = manifest(folder)
    if "complexity_ratio" not in m or m["complexity_ratio"].isna().all():
        shapes = pd.DataFrame([shape_metrics(read_mask(os.path.join(folder, f))) for f in m["file"]])
        m = pd.concat([m.drop(columns=[c for c in shapes if c in m]), shapes], axis=1)
    return m.set_index("layer")[["complexity_class", "complexity_ratio", "area_mm2"]]


def summary(df):
    rows = []
    groups = list(df.groupby(["size", "complexity_class"])) + [((s, "all"), g) for s, g in df.groupby("size")] \
        + [(("all", "all"), df)]
    for (size, cls), g in groups:
        d = g.fill_pct - g.coverage_pct
        rows.append({"size": size, "class": cls, "n": len(g),
                     "coverage_median": g.coverage_pct.median(), "fill_median": g.fill_pct.median(),
                     "diff_median": d.median(), "diff_q1": d.quantile(.25), "diff_q3": d.quantile(.75),
                     "bias": d.mean(), "loa_low": d.mean() - 1.96 * d.std(), "loa_high": d.mean() + 1.96 * d.std(),
                     "within_1pp": 100 * (d.abs() <= 1).mean(), "within_3pp": 100 * (d.abs() <= 3).mean(),
                     "env_overspill_median": g.env_overspill_pct.median(),
                     "overspill_median": g.overspill_pct.median()})
    return pd.DataFrame(rows)


if __name__ == "__main__":
    todo = tasks(REGENERATE_GCODE)
    print(f"{len(todo)} layers, {C.WORKERS} workers", flush=True)
    raw, sweep = [], []
    with Pool(C.WORKERS) as pool:
        for k, (r, s) in enumerate(pool.imap(measure, todo, chunksize=2), 1):
            raw.append(r)
            sweep.append(s)
            if k % 100 == 0 or k == len(todo):
                print(f"  {k}/{len(todo)}", flush=True)
    df = pd.DataFrame(raw)
    df.to_csv(C.output("coverage_fill", "coverage_fill_raw.csv"), index=False)
    for size in C.TEST_SIZES:
        info, sel = layer_info(size), df["size"] == size
        for c in info.columns:
            df.loc[sel, c] = df.loc[sel, "layer"].map(info[c])
    df.sort_values(["size", "layer"]).to_csv(C.output("coverage_fill", "coverage_fill_raster.csv"), index=False)
    sw = df.copy()
    sw["fill_pct"] = [s["fill_pct"] for s in sweep]
    sw["overspill_pct"] = [s["overspill_pct"] for s in sweep]
    sw = sw.drop(columns="fill_subpx_pct").sort_values(["size", "layer"])
    sw.to_csv(C.output("coverage_fill", "coverage_fill.csv"), index=False)
    s = summary(sw)
    s.to_csv(C.output("coverage_fill", "summary.csv"), index=False)
    print(s[s["class"] == "all"].round(2).to_string(index=False))
