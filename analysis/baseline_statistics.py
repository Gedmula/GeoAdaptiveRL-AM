"""Statistics of RL against the five solid PrusaSlicer patterns on the 500x500 test layers.

Metrics per layer
  time_per_cm2       print time / slice area (s/cm^2)
  time_over_lb       print time / its lower bound (slice area / 0.45 mm at the print speed)
  starts_per_cm2     extrusion starts / slice area
  travel_per_cm2     travel length / slice area (mm/cm^2)
  corners_per_10mm   direction changes within beads per 10 mm of extruded path
  fill_pct, void_largest_mm2, edge_fill_pct, overspill_pct, over_deposition_pct
Layers where RL coverage is below 90 % are left out (paired_all_slices.csv keeps them).

  summary_by_class.csv   median and quartiles per toolpath and class
  paired.csv             RL against each pattern over the layers: Hodges-Lehmann estimate with its
                         distribution-free 95 % CI, Wilcoxon signed-rank test with Holm correction over
                         the patterns, and the outcome: superior / inferior (significant and beyond the
                         margin), equivalent (both one-sided tests against the margin significant) or
                         inconclusive. Cost metrics are compared on the log scale, percentages in points.
  friedman.csv, ranks.csv   Friedman test with Kendall's W; mean ranks per class
  profiles.csv           Dolan-More performance profiles
  pareto.csv             share of layers on the Pareto front of (time, starts, unfilled share)
  paired_junction.csv    print time from the junction-aware planner
  exclusions.csv         layers left out

    python analysis/baseline_statistics.py
"""

import math

import numpy as np
import pandas as pd
from scipy import stats

import config as C
from layers import manifest

SOLID = list(C.SOLID)
CLASSES = list(C.CLASSES)
# metric: (better direction, scale, equivalence margin, compared patterns)
METRICS = {
    "time_per_cm2":        ("lower", "log", 0.05, SOLID),
    "time_over_lb":        ("lower", "log", 0.05, SOLID),
    "starts_per_cm2":      ("lower", "log", 0.10, SOLID),
    "travel_per_cm2":      ("lower", "abs", None, SOLID),
    "corners_per_10mm":    ("lower", "log", 0.10, SOLID),
    "fill_pct":            ("higher", "abs", 1.0, SOLID),
    "void_largest_mm2":    ("lower", "abs", None, SOLID),
    "edge_fill_pct":       ("higher", "abs", 1.0, SOLID),
    "overspill_pct":       ("lower", "abs", 1.0, SOLID),
    "over_deposition_pct": ("lower", "abs", 1.0, SOLID),
}
JUNCTION = {"time_junction_per_cm2": ("lower", "log", 0.05, SOLID)}


def rl_coverage():
    cov = pd.read_csv(C.source("coverage_fill", "coverage_fill.csv"))
    return cov[cov["size"] == C.COMPARISON_SIZE].set_index("layer")["coverage_pct"]


def load(table, min_coverage=C.MIN_COVERAGE):
    df = pd.read_csv(C.source("baseline_comparison", table))
    df = df[df.status == "ok"].copy()
    df["rl_coverage"] = df.layer.map(rl_coverage())
    if min_coverage:
        df = df[df.rl_coverage >= min_coverage]
    cm2 = df.area_mm2 / 100.0
    df["time_per_cm2"] = df.print_time_s / cm2
    df["time_over_lb"] = df.print_time_s / df.time_lb_s
    df["starts_per_cm2"] = df.extrusion_starts / cm2
    df["travel_per_cm2"] = df.travel_mm / cm2
    df["corners_per_10mm"] = df.direction_changes_per_10mm
    df["travel_moves"] = df.retractions + df.unretracted_travels
    df["time_junction_per_cm2"] = df.print_time_junction_s / cm2
    keep = df.groupby("layer").toolpath.transform("count") == df.toolpath.nunique()
    return df[keep]


def hl_ci(d, alpha=0.05):
    """Hodges-Lehmann estimate and distribution-free CI from the Walsh averages."""
    d = np.sort(np.asarray(d, float))
    n = len(d)
    walsh = ((d[:, None] + d[None, :]) / 2.0)[np.triu_indices(n)]
    walsh.sort()
    z = stats.norm.ppf(1 - alpha / 2)
    k = max(int(math.floor(n * (n + 1) / 4 - z * math.sqrt(n * (n + 1) * (2 * n + 1) / 24))), 0)
    return float(np.median(walsh)), float(walsh[k]), float(walsh[-k - 1])


def holm(p):
    p = np.asarray(p, float)
    out, run = np.empty_like(p), 0.0
    for rank, i in enumerate(np.argsort(p)):
        run = max(run, min(1.0, (len(p) - rank) * p[i]))
        out[i] = run
    return out


def paired(df, metrics=METRICS, by_class=False):
    rows = []
    groups = [("all", df)] + ([(c, df[df["class"] == c]) for c in CLASSES] if by_class else [])
    for cls, g in groups:
        w = g.pivot(index="layer", columns="toolpath")
        for metric, (direction, scale, margin, pats) in metrics.items():
            res = []
            for p in pats:
                a, b = w[metric]["RL"], w[metric][p]
                ok = a.notna() & b.notna() & ((a > 0) & (b > 0) if scale == "log" else True)
                a, b = a[ok], b[ok]
                d = np.log(a) - np.log(b) if scale == "log" else a - b
                if len(d) < 5 or np.allclose(d, 0):
                    res.append(dict(cls=cls, metric=metric, pattern=p, n=len(d), est=0.0, lo=0.0, hi=0.0, p=1.0,
                                    p_eq=0.0 if margin else math.nan))
                    continue
                est, lo, hi = hl_ci(d)
                p_val = stats.wilcoxon(d, zero_method="zsplit").pvalue
                if margin:
                    m = math.log(1 + margin) if scale == "log" else margin
                    p_eq = max(stats.wilcoxon(d + m, alternative="greater", zero_method="zsplit").pvalue,
                               stats.wilcoxon(d - m, alternative="less", zero_method="zsplit").pvalue)
                else:
                    p_eq = math.nan
                res.append(dict(cls=cls, metric=metric, pattern=p, n=len(d), est=est, lo=lo, hi=hi, p=p_val, p_eq=p_eq))
            for r, pa in zip(res, holm([r["p"] for r in res])):
                r["p_holm"] = pa
                if scale == "log":
                    r.update(est_rel=100 * (math.exp(r["est"]) - 1), lo_rel=100 * (math.exp(r["lo"]) - 1),
                             hi_rel=100 * (math.exp(r["hi"]) - 1))
                better = r["est"] < 0 if direction == "lower" else r["est"] > 0
                mlim = (math.log(1 + margin) if scale == "log" else margin) if margin else 0.0
                if pa < 0.05 and abs(r["est"]) > mlim:
                    r["outcome"] = "superior" if better else "inferior"
                elif margin and r["p_eq"] < 0.05:
                    r["outcome"] = "equivalent"
                else:
                    r["outcome"] = "inconclusive"
            rows += res
    return pd.DataFrame(rows)


def friedman_ranks(df):
    out, ranks = [], []
    for metric, (direction, _, _, pats) in METRICS.items():
        tps = ["RL"] + [p for p in pats if p in SOLID]
        w = df[df.toolpath.isin(tps)].pivot(index="layer", columns="toolpath", values=metric)[tps].dropna()
        x = w.values if direction == "lower" else -w.values
        chi, p = stats.friedmanchisquare(*x.T)
        n, k = x.shape
        out.append(dict(metric=metric, n=n, k=k, chi2=chi, p=p, kendall_w=chi / (n * (k - 1))))
        r = pd.DataFrame(stats.rankdata(x, axis=1), index=w.index, columns=tps)
        r["class"] = df.drop_duplicates("layer").set_index("layer").loc[r.index, "class"]
        m = r.groupby("class")[tps].mean().reindex(CLASSES)
        m.loc["all"] = r[tps].mean()
        m["metric"] = metric
        ranks.append(m.reset_index())
    return pd.DataFrame(out), pd.concat(ranks)


def profiles(df, taus=np.unique(np.concatenate([np.linspace(1, 4, 301), np.geomspace(4, 10, 60)]))):
    rows = []
    for metric in ("time_per_cm2", "starts_per_cm2", "travel_per_cm2", "fill_pct"):
        tps = ["RL"] + METRICS[metric][3]
        w = df[df.toolpath.isin(tps)].pivot(index="layer", columns="toolpath", values=metric)[tps].dropna()
        if metric == "fill_pct":
            cost = (100.0 - w).clip(lower=0.05)          # Unfilled share, floored at 0.05 %.
        elif metric == "travel_per_cm2":
            cost = w + 1.0                               # RL often has no travel.
        else:
            cost = w
        ratio = cost.div(cost.min(axis=1), axis=0)
        cls = df.drop_duplicates("layer").set_index("layer").loc[ratio.index, "class"]
        for c in ["all"] + CLASSES:
            sub = ratio if c == "all" else ratio[cls == c]
            for tp in tps:
                r = sub[tp].values
                rows += [dict(metric=metric, cls=c, toolpath=tp, tau=t, rho=float((r <= t + 1e-12).mean())) for t in taus]
    return pd.DataFrame(rows)


def pareto(df):
    tps = ["RL"] + SOLID
    w = df[df.toolpath.isin(tps)].pivot(index="layer", columns="toolpath")
    cls = df.drop_duplicates("layer").set_index("layer")["class"]
    rows = []
    for layer in w.index:
        obj = np.array([[w.loc[layer, ("time_per_cm2", t)], w.loc[layer, ("starts_per_cm2", t)],
                         100 - w.loc[layer, ("fill_pct", t)]] for t in tps])
        for i, t in enumerate(tps):
            dom = any(np.all(obj[j] <= obj[i] * 1.01 + 1e-9) and np.any(obj[j] < obj[i] * 0.99 - 1e-9)
                      for j in range(len(tps)) if j != i)
            rows.append(dict(layer=layer, cls=cls[layer], toolpath=t, front=not dom))
    p = pd.DataFrame(rows)
    out = p.groupby(["cls", "toolpath"]).front.mean().unstack() * 100
    out.loc["all"] = p.groupby("toolpath").front.mean() * 100
    return out.reindex(CLASSES + ["all"])


def summary(df):
    rows = []
    for (tp, c), g in list(df.groupby(["toolpath", "class"])) + [((tp, "all"), g) for tp, g in df.groupby("toolpath")]:
        r = {"toolpath": tp, "class": c, "n": len(g)}
        for m in list(METRICS) + ["travel_mm", "travel_moves"]:
            r[f"{m}_median"] = g[m].median()
            r[f"{m}_q1"] = g[m].quantile(.25)
            r[f"{m}_q3"] = g[m].quantile(.75)
        rows.append(r)
    return pd.DataFrame(rows)


def junction(df):
    out = paired(df, JUNCTION)
    f = (df.print_time_junction_s / df.print_time_s).groupby(df.toolpath).median().rename("median_junction_factor")
    return out.merge(f, left_on="pattern", right_index=True)


def exclusions():
    man = manifest(C.test_folder(C.COMPARISON_SIZE))
    man["coverage"] = man.layer.map(rl_coverage())
    rows = []
    for cls, part in [(c, man[man.complexity_class == c]) for c in CLASSES] + [("all", man)]:
        below = part.coverage < C.MIN_COVERAGE
        rows.append({"class": cls, "n_layers": len(part), "excluded": int(below.sum()), "kept": int((~below).sum()),
                     "excluded_layers": " ".join(f"{l} ({c:.1f} %)" for l, c in
                                                 zip(part.loc[below, "layer"], part.loc[below, "coverage"]))})
    return pd.DataFrame(rows)


if __name__ == "__main__":
    df = load("per_slice_metrics.csv")
    print(f"{df.layer.nunique()} layers, {len(df)} rows")
    path = lambda name: C.output("baseline_comparison", name)
    summary(df).to_csv(path("summary_by_class.csv"), index=False)
    paired(df, by_class=True).to_csv(path("paired.csv"), index=False)
    fr, rk = friedman_ranks(df)
    fr.to_csv(path("friedman.csv"), index=False)
    rk.to_csv(path("ranks.csv"), index=False)
    profiles(df).to_csv(path("profiles.csv"), index=False)
    pareto(df).to_csv(path("pareto.csv"))
    paired(load("per_slice_metrics.csv", min_coverage=None)).to_csv(path("paired_all_slices.csv"), index=False)
    junction(df).to_csv(path("paired_junction.csv"), index=False)
    exclusions().to_csv(path("exclusions.csv"), index=False)
