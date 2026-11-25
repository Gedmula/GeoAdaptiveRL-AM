"""Compare every table in results/reproduced/ with the published one in results/processed/.

Rows are matched on the text columns (and size, where present). Numbers count as equal
within a relative tolerance of 1e-6; polygon areas from shapely can differ in the last
digits between library versions. The gcode column, a file path (original project paths in the
published tables, see README section 9), is not compared.

    python analysis/compare.py
"""

import glob
import os

import numpy as np
import pandas as pd

import config as C

RTOL = 1e-6


def keys(df):
    k = [c for c in df.columns if df[c].dtype == object or pd.api.types.is_string_dtype(df[c])]
    return (["size"] if "size" in df and "size" not in k else []) + k


def compare(new, pub):
    extra = ""
    if "toolpath" in pub and set(pub.toolpath) - set(new.toolpath):
        # The published per-layer tables also hold the three sparse patterns, which have no G-code here.
        only = sorted(set(pub.toolpath) - set(new.toolpath))
        pub = pub[pub.toolpath.isin(new.toolpath)].reset_index(drop=True)
        extra = f" (published table also has rows for {', '.join(only)})"
    result = _compare(new, pub)
    return result + extra if result == "equal" else result


def _compare(new, pub):
    new, pub = new.drop(columns=["gcode"], errors="ignore"), pub.drop(columns=["gcode"], errors="ignore")
    if set(new.columns) != set(pub.columns):
        return f"columns differ: only reproduced {sorted(set(new) - set(pub))}, only published {sorted(set(pub) - set(new))}"
    if len(new) != len(pub):
        return f"rows differ: {len(new)} reproduced, {len(pub)} published"
    k = keys(pub)
    new, pub = new[pub.columns].copy(), pub.copy()
    for c in k:
        new[c], pub[c] = new[c].fillna("").astype(str), pub[c].fillna("").astype(str)
    new = new.sort_values(k, kind="stable").reset_index(drop=True)
    pub = pub.sort_values(k, kind="stable").reset_index(drop=True)
    diffs = []
    for c in pub.columns:
        a, b = new[c], pub[c]
        if c in k:
            if not (a == b).all():
                diffs.append(f"{c} (text)")
            continue
        a, b = pd.to_numeric(a, errors="coerce").to_numpy(float), pd.to_numeric(b, errors="coerce").to_numpy(float)
        if (np.isnan(a) != np.isnan(b)).any():
            diffs.append(f"{c} (missing values)")
            continue
        ok = ~np.isnan(b)
        rel = np.abs(a[ok] - b[ok]) / np.maximum(np.abs(b[ok]), 1e-12)
        if len(rel) and rel.max() > RTOL:
            diffs.append(f"{c} (max rel. diff {rel.max():.2g})")
    return "equal" if not diffs else "differs: " + ", ".join(diffs)


if __name__ == "__main__":
    files = sorted(glob.glob(os.path.join(C.REPRODUCED, "**", "*.csv"), recursive=True))
    for path in files:
        rel = os.path.relpath(path, C.REPRODUCED)
        if rel.startswith("gcode_rl"):
            continue
        published = os.path.join(C.PROCESSED, rel)
        if rel == os.path.join("training_series.csv"):
            published = os.path.join(C.TRAINING_LOGS, "training_series.csv")
        if not os.path.exists(published):
            print(f"{rel}: no published table")
            continue
        print(f"{rel}: {compare(pd.read_csv(path), pd.read_csv(published))}")
