"""Train/test gap and scale extrapolation of the policy.

The policy was run on a sample of training layers at each training grid size, drawn to match
the class mix of that size's test set and leaving out training layers that copy a test layer
(sample.csv; rollouts in results/raw/rl_train_layers_generalization/, metrics in
generalization/train_<grid>/metrics.csv).

  train_test_gap.csv      per size and metric, test - train as the class-weighted difference of
                          medians (rates for completion) with a 95 % bootstrap CI that resamples within
                          classes; p from the Cochran-Mantel-Haenszel test (completion) or the van Elteren
                          test (other metrics), stratified by class, Holm-corrected over the sizes
  train_test_summary.csv  median and quartiles per size and set
  scale.csv               test performance per size, and on the 500x500 layers larger than every training layer
Metrics: completed, coverage (%), Q, steps / S_part, travel_per_ideal, extrusion starts per cm^2.

    python analysis/generalization.py
"""

import os

import numpy as np
import pandas as pd
from scipy.stats import norm, rankdata
from statsmodels.stats.contingency_tables import StratifiedTable

import config as C

N_SAMPLE = 300
MIN_CLASS = 10
N_BOOT = 2000
SEED = 0
METRICS = ("completed", "coverage", "Q", "steps_ratio", "travel_per_ideal", "starts_cm2")


def prepare(df):
    df = df.copy()
    df["completed"] = (df["outcome"] == "completed") * 100.0
    df["coverage"] = df["coverage"] * 100.0
    df["steps_ratio"] = df["steps"] / df["S_part"]
    df["starts_cm2"] = df["beads"] / (df["area_mm2"] / 100.0)
    return df


def stat(x, metric):
    return x.mean() if metric == "completed" else x.median()


def unique_train_layers(size):
    """Training manifest without the layers that copy a test layer (duplicate_of)."""
    m = pd.read_csv(os.path.join(C.train_folder(size), "manifest.csv"))
    return m[m.duplicate_of.isna()] if "duplicate_of" in m else m


def sample(size, test):
    """Training layers drawn per class in the proportions of the test set."""
    train = unique_train_layers(size)
    share = test[test["size"] == size]["complexity_class"].value_counts(normalize=True)
    parts = []
    for cls, p in share.items():
        pool = train[train["complexity_class"] == cls]
        parts.append(pool.sample(n=min(len(pool), max(1, round(p * N_SAMPLE))), random_state=SEED))
    return pd.concat(parts).astype(str).replace("nan", "")


def gap(train, test, metric, rng):
    classes = [c for c in test.complexity_class.unique()
               if (train.complexity_class == c).sum() >= MIN_CLASS and (test.complexity_class == c).sum() >= MIN_CLASS]
    w = test[test.complexity_class.isin(classes)].complexity_class.value_counts(normalize=True)
    tr = {c: train.loc[train.complexity_class == c, metric].to_numpy() for c in classes}
    te = {c: test.loc[test.complexity_class == c, metric].to_numpy() for c in classes}
    est = lambda a, b: sum(w[c] * (stat(pd.Series(b[c]), metric) - stat(pd.Series(a[c]), metric)) for c in classes)
    e = est(tr, te)
    boots = [est({c: rng.choice(tr[c], len(tr[c])) for c in classes}, {c: rng.choice(te[c], len(te[c])) for c in classes})
             for _ in range(N_BOOT)]
    lo, hi = np.percentile(boots, [2.5, 97.5])
    base = sum(w[c] * stat(pd.Series(tr[c]), metric) for c in classes)
    return dict(gap=e, lo=lo, hi=hi, train=base, test=base + e, classes=",".join(classes),
                n_train=sum(len(tr[c]) for c in classes), n_test=sum(len(te[c]) for c in classes))


def cmh(train, test, classes):
    tabs = []
    for c in classes:
        a = test.loc[test.complexity_class == c, "completed"] > 0
        b = train.loc[train.complexity_class == c, "completed"] > 0
        tabs.append(np.array([[a.sum(), (~a).sum()], [b.sum(), (~b).sum()]], float))
    if all(t[:, 1].sum() == 0 for t in tabs):          # Every layer completed.
        return 1.0
    return StratifiedTable(tabs).test_null_odds(correction=False).pvalue


def van_elteren(train, test, metric, classes):
    num = var = 0.0
    for c in classes:
        a = test.loc[test.complexity_class == c, metric].to_numpy()
        b = train.loc[train.complexity_class == c, metric].to_numpy()
        n1, n2 = len(a), len(b)
        n = n1 + n2
        r = rankdata(np.concatenate([a, b]))
        w = 1.0 / (n + 1)
        _, t = np.unique(r, return_counts=True)
        v = n1 * n2 / 12.0 * ((n + 1) - (t ** 3 - t).sum() / (n * (n - 1)))
        num += w * (r[:n1].sum() - n1 * (n + 1) / 2.0)
        var += w * w * v
    return 1.0 if var == 0 else 2 * norm.sf(abs(num) / np.sqrt(var))


def holm(p):
    p = np.asarray(p, float)
    out, run = np.empty_like(p), 0.0
    for k, i in enumerate(np.argsort(p)):
        run = max(run, min(1.0, (len(p) - k) * p[i]))
        out[i] = run
    return out


def train_test(test_all):
    rng = np.random.default_rng(SEED)
    rows, summary = [], []
    for s in C.TRAIN_SIZES:
        train = prepare(pd.read_csv(C.source("generalization", f"train_{C.grid(s)}", "metrics.csv")))
        test = test_all[test_all["size"] == s]
        for m in METRICS:
            g = gap(train, test, m, rng)
            cl = g["classes"].split(",")
            g["p"] = cmh(train, test, cl) if m == "completed" else van_elteren(train, test, m, cl)
            g["method"] = "CMH" if m == "completed" else "van Elteren"
            rows.append({"size": s, "metric": m, **g})
        for name, d in (("train", train), ("test", test)):
            summary.append({"size": s, "set": name, "n": len(d), **{m: stat(d[m], m) for m in METRICS},
                            **{f"{m}_q1": d[m].quantile(.25) for m in METRICS if m != "completed"},
                            **{f"{m}_q3": d[m].quantile(.75) for m in METRICS if m != "completed"}})
    out = pd.DataFrame(rows)
    out["p_holm"] = out.groupby("metric").p.transform(holm)
    return out, pd.DataFrame(summary)


def scale(test_all):
    amax = pd.concat([unique_train_layers(s) for s in C.TRAIN_SIZES]).area_mm2.max()
    rows = [{"size": s, "subset": "all", "n": len(g), **{m: stat(g[m], m) for m in METRICS}}
            for s, g in ((s, test_all[test_all["size"] == s]) for s in C.TEST_SIZES)]
    g = test_all[(test_all["size"] == C.COMPARISON_SIZE) & (test_all.area_mm2 > amax)]
    rows.append({"size": C.COMPARISON_SIZE, "subset": "larger than every training slice", "n": len(g),
                 **{m: stat(g[m], m) for m in METRICS}})
    out = pd.DataFrame(rows)
    out["train_area_max_mm2"] = amax
    return out


if __name__ == "__main__":
    per_layer = pd.read_csv(C.source("transfer", "transfer_per_layer.csv"))
    for s in C.TRAIN_SIZES:
        sample(s, per_layer).to_csv(C.output("generalization", f"train_{C.grid(s)}", "sample.csv"), index=False)
    test_all = prepare(per_layer)
    scale(test_all).to_csv(C.output("generalization", "scale.csv"), index=False)
    gaps, summary = train_test(test_all)
    gaps.to_csv(C.output("generalization", "train_test_gap.csv"), index=False)
    summary.to_csv(C.output("generalization", "train_test_summary.csv"), index=False)
    print(gaps[["size", "metric", "gap", "lo", "hi", "p_holm"]].round(3).to_string(index=False))
