"""Training history from the TensorBoard logs, averaged in bins of 1M timesteps.

Output: training_series.csv (run, grid size, bin centre and one column per scalar), as
training_logs/training_series.csv.

    python analysis/training_series.py
"""

import glob
import os

import numpy as np
import pandas as pd
from tensorboard.backend.event_processing.event_accumulator import EventAccumulator

import config as C

RUNS = [                         # (log folder, grid size, run name in the table)
    ("stage1_100x100", 100, "PPO_v2_100x100_20261030_0943_1"),
    ("stage2_200x200", 200, "PPO_v2_200x200_20261030_1658_0"),
    ("stage3_400x400", 400, "PPO_v2_400x400_20261031_0206_0"),
]
PREFIXES = ("episode/", "episode_reward/", "rollout/", "curriculum/", "outcome/")
BIN = 1_000_000


def read(folder):
    ea = EventAccumulator(sorted(glob.glob(os.path.join(folder, "events*")))[-1], size_guidance={"scalars": 0})
    ea.Reload()
    return {t: np.array([(e.step, e.value) for e in ea.Scalars(t)]) for t in ea.Tags()["scalars"]
            if t.startswith(PREFIXES)}


def binned(folder, size, run):
    s = read(folder)
    lo, hi = s["episode/coverage"][:, 0].min(), s["episode/coverage"][:, 0].max()
    edges = np.arange(np.floor(lo / BIN) * BIN, hi + BIN, BIN)
    rows = [{"run": run, "size": size, "timestep": edges[i] + BIN / 2} for i in range(len(edges) - 1)]
    for tag, d in s.items():
        idx = np.digitize(d[:, 0], edges) - 1
        for i, row in enumerate(rows):
            row[tag] = d[idx == i, 1].mean() if (idx == i).any() else np.nan
    print(f"{run}: {lo / 1e6:.1f}-{hi / 1e6:.1f}M steps, {len(s)} scalars")
    return rows


if __name__ == "__main__":
    rows = [r for folder, size, run in RUNS for r in binned(os.path.join(C.TRAINING_LOGS, folder), size, run)]
    pd.DataFrame(rows).to_csv(C.output("training_series.csv"), index=False)
