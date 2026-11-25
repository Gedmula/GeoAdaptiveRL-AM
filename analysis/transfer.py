"""Transfer of the policy across the four test grid sizes, from the rollout metrics.

  transfer_per_layer.csv   every test layer of every size: its rollout metrics (metrics.csv) and
                           its complexity (computed from the slice where the manifest has none)
  transfer.csv             per size and class: completion, coverage (mean, median, 5th percentile),
                           print runs and the slice quality Q
  transfer_fits.csv        per size: completion against log CR by logistic regression (with the CR
                           at 90 % completion), and LOESS of Q and of completion against CR

    python analysis/transfer.py
"""

import math
import os

import numpy as np
import pandas as pd
import statsmodels.api as sm

import config as C
from layers import read_mask, shape_metrics

LOESS_FRAC = 0.5


def per_layer():
    frames = []
    for size in C.TEST_SIZES:
        folder = C.test_folder(size)
        m = pd.read_csv(os.path.join(C.RAW, C.grid(size), "metrics.csv"))
        if "complexity_ratio" not in m or m["complexity_ratio"].isna().all():
            shapes = pd.DataFrame([{"file": f, **shape_metrics(read_mask(os.path.join(folder, f)))} for f in m["file"]])
            m = m.drop(columns=[c for c in shapes.columns if c != "file" and c in m]).merge(shapes, on="file")
        m.insert(0, "size", size)
        frames.append(m)
    df = pd.concat(frames, ignore_index=True)
    df["completed"] = df["outcome"] == "completed"
    return df


def tables(t):
    rows, fits = [], []
    for size, part in t.groupby("size"):
        for cls, g in [(c, part[part["complexity_class"] == c]) for c in C.CLASSES] + [("all", part)]:
            if g.empty:
                continue
            rows.append({"size": size, "class": cls, "n_layers": len(g),
                         "completion_pct": 100 * g["completed"].mean(),
                         "coverage_pct_mean": 100 * g["coverage"].mean(),
                         "coverage_pct_median": 100 * g["coverage"].median(),
                         "coverage_pct_p5": 100 * g["coverage"].quantile(0.05),
                         "print_runs_median": g["beads"].median(), "print_runs_mean": g["beads"].mean(),
                         "Q_median": g["Q"].median(), "Q_mean": g["Q"].mean(), "Q_p5": g["Q"].quantile(0.05)})

        x, y = part["complexity_ratio"].to_numpy(float), part["completed"].to_numpy(float)
        fit = {"size": size, "n_layers": len(part), "cr_min": x.min(), "cr_max": x.max()}
        try:
            res = sm.Logit(y, sm.add_constant(np.log(x))).fit(disp=0)
            b0, b1 = res.params
            fit.update(logit_b0=b0, logit_b1_log_cr=b1, logit_p_b1=res.pvalues[1],
                       logit_cr_at_90pct=math.exp((math.log(9) - b0) / b1) if b1 != 0 else math.nan,
                       logit_pseudo_r2=res.prsquared)
        except Exception as err:                  # Perfect separation, e.g. every layer completed.
            fit.update(logit_error=f"{type(err).__name__}: {err}")
        low = sm.nonparametric.lowess(part["Q"].to_numpy(float), x, frac=LOESS_FRAC, return_sorted=True)
        for cr in (1.1, 1.25, 1.5, 1.75, 2.0, 2.5, 3.0, 4.0, 5.0, 6.0):
            fit[f"loess_Q_at_cr_{cr:g}"] = float(np.interp(cr, low[:, 0], low[:, 1])) \
                if low[0, 0] <= cr <= low[-1, 0] else math.nan
        lowc = sm.nonparametric.lowess(y, x, frac=LOESS_FRAC, return_sorted=True)
        for cr in (1.1, 1.5, 2.0, 2.5, 3.0, 4.0, 5.0):
            fit[f"loess_completion_at_cr_{cr:g}"] = float(np.interp(cr, lowc[:, 0], lowc[:, 1])) \
                if lowc[0, 0] <= cr <= lowc[-1, 0] else math.nan
        fits.append(fit)
    return pd.DataFrame(rows), pd.DataFrame(fits)


if __name__ == "__main__":
    t = per_layer()
    t.to_csv(C.output("transfer", "transfer_per_layer.csv"), index=False)
    summary, fits = tables(t)
    summary.to_csv(C.output("transfer", "transfer.csv"), index=False)
    fits.to_csv(C.output("transfer", "transfer_fits.csv"), index=False)
    print(summary[summary["class"] == "all"].round(3).to_string(index=False))
