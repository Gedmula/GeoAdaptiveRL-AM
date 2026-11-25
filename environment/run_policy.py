"""Run the reported policy (greedy actions) on the layers of a slice folder.

For every layer it writes
  <class>/json/<name>_path.json      the path ([row, col, printed] per step) and the layer metrics,
                                     in the format of results/raw/
  <class>/actions/<name>_actions.txt the action of every step
and for the run metrics.csv (one row per layer) and summary.json. A layer counts as completed
once its coverage reaches 98 %; the environment's own ending is kept as env_outcome.

A "test" run uses the test slices of that grid size, a "train" run the sample of training slices
of the train/test comparison (results/processed/generalization/train_<grid>/sample.csv). Output
goes to results/reproduced/rollouts/<test|train>_<grid>/. Edit the settings below and run:

    python environment/run_policy.py
"""

import csv
import json
import os
import sys
import time
from multiprocessing import get_context

import numpy as np

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
sys.path.insert(0, HERE)

import settings as C  # noqa: E402
from toolpath_env import ToolpathEnv  # noqa: E402

# === SETTINGS ===
RUNS = [("test", 100), ("test", 200), ("test", 400), ("test", 500),   # (layer set, grid size)
        ("train", 100), ("train", 200), ("train", 400)]
LIMIT = None                     # Layers per run; None: all.
WORKERS = 10                     # Parallel processes, each with its own copy of the model.
MODEL = os.path.join(ROOT, "models", "stage3_400x400", "best_model.zip")

COMPLETE_COVERAGE = 0.98
SEED = 0
COMPLEXITY_COLUMNS = ("area_mm2", "perimeter_mm", "pa_ratio", "complexity_ratio", "complexity_class")
COUNT_KEYS = {"steps", "print_steps", "travel_steps", "blocked_steps", "oscillation_moves", "beads",
              "spilled_cells", "overfilled_cells", "void_clusters", "largest_void", "printable_clusters",
              "unprintable_cells", "stranded_cells", "total_goals", "islands"}

_model = None


def load_model(path):
    from stable_baselines3 import PPO
    # A two-step rollout buffer: the saved settings would allocate the training buffer.
    return PPO.load(path, device="cpu", custom_objects={"n_steps": 2, "batch_size": 2})


def _init(path):
    global _model
    import torch
    torch.set_num_threads(1)
    _model = load_model(path)


def rollout(model, image):
    """Greedy episode from the bottom-left corner: (env, final info, actions, return, seconds)."""
    env = ToolpathEnv(image)
    obs, _ = env.reset(seed=SEED)
    actions, total, t0 = [], 0.0, time.time()
    while True:
        action, _ = model.predict(obs, deterministic=True)
        actions.append(int(action))
        obs, reward, terminated, truncated, info = env.step(int(action))
        total += reward
        if terminated or truncated:
            return env, info, actions, total, time.time() - t0


def path_json(env, info, total, seconds):
    path = [[float(y), float(x), bool(p)] for y, x, p in info["episode_path"]]
    m = info["episode_metrics"]
    n_dep = sum(1 for *_, p in path if p)
    outcome = "completed" if m["coverage"] >= COMPLETE_COVERAGE else info["outcome"]
    return {
        "path": path,
        "grid_info": {"original_shape": [env.height, env.width], "padded_shape": [env.N, env.N],
                      "total_goal_cells": env.total_goals, "cell_size_mm": C.CELL_MM},
        "scale_metadata": None,
        "completion_stats": {"progress_percentage": 100.0 * m["coverage"],
                             "remaining_cells": env.total_goals - env.n_covered,
                             "deposited_cells": env.n_covered, "completion_ratio": m["coverage"]},
        "path_stats": {"total_points": len(path), "deposit_points": n_dep, "travel_points": len(path) - n_dep,
                       "deposit_ratio": n_dep / max(len(path), 1)},
        "performance_metrics": {**{k: float(v) for k, v in m.items()}, "outcome": outcome,
                                "env_outcome": info["outcome"], "complete_coverage": COMPLETE_COVERAGE,
                                "total_reward": total, "reward_totals": info["reward_totals"]},
        "execution_stats": {"seconds": seconds, "steps": env.steps, "deterministic": True, "seed": SEED},
    }


def run_task(task):
    row, folder, out_dir = task
    env, info, actions, total, seconds = rollout(_model, os.path.join(folder, row["file"]))
    data = path_json(env, info, total, seconds)
    sub, name = os.path.dirname(row["file"]), os.path.splitext(os.path.basename(row["file"]))[0]
    for kind, fname, text in (("json", f"{name}_path.json", json.dumps(data)),
                              ("actions", f"{name}_actions.txt", "\n".join(map(str, actions)) + "\n")):
        target = os.path.join(out_dir, sub, kind, fname)
        os.makedirs(os.path.dirname(target), exist_ok=True)
        with open(target, "w") as f:
            f.write(text)
    m = info["episode_metrics"]
    result = {"file": row["file"], "source": row.get("source", ""), "level": row.get("level", ""),
              **{k: row[k] for k in COMPLEXITY_COLUMNS if row.get(k) not in (None, "")},
              "outcome": data["performance_metrics"]["outcome"], "env_outcome": info["outcome"],
              "return": round(total, 3),
              **{k: (int(v) if k in COUNT_KEYS else round(float(v), 4)) for k, v in m.items()},
              "seconds": round(seconds, 2)}
    print(f"{row['file']:28s} {result['outcome']:9s} coverage {m['coverage']:.3f} beads {m['beads']:4d} "
          f"Q {m['Q']:.2f}", flush=True)
    return result


def layers(kind, size, limit):
    grid = f"{size}x{size}"
    if kind == "train":
        folder = os.path.join(ROOT, "slices", "train", grid)
        listing = os.path.join(ROOT, "results", "processed", "generalization", f"train_{grid}", "sample.csv")
    else:
        folder = os.path.join(ROOT, "slices", "test", grid)
        listing = os.path.join(folder, "manifest.csv")
    with open(listing) as f:
        rows = list(csv.DictReader(f))
    return folder, rows[:limit] if limit else rows


def run(kind, size):
    folder, rows = layers(kind, size, LIMIT)
    out_dir = os.path.join(ROOT, "results", "reproduced", "rollouts", f"{kind}_{size}x{size}")
    os.makedirs(out_dir, exist_ok=True)
    print(f"{len(rows)} layers of {folder}, {WORKERS} workers", flush=True)
    t0 = time.time()
    with get_context("spawn").Pool(WORKERS, initializer=_init, initargs=(MODEL,)) as pool:
        results = list(pool.imap(run_task, [(r, folder, out_dir) for r in rows]))

    with open(os.path.join(out_dir, "metrics.csv"), "w", newline="") as f:
        w = csv.DictWriter(f, fieldnames=list(results[0]))
        w.writeheader()
        w.writerows(results)
    numeric = [k for k, v in results[0].items() if isinstance(v, (int, float)) and not isinstance(v, bool)]
    summary = {"model": os.path.relpath(MODEL, ROOT).replace(os.sep, "/"), "layers": len(results),
               "completed": float(np.mean([r["outcome"] == "completed" for r in results])),
               **{k: float(np.mean([r[k] for r in results])) for k in numeric}, "seconds": time.time() - t0}
    with open(os.path.join(out_dir, "summary.json"), "w") as f:
        json.dump(summary, f, indent=2)
    print(f"completed {summary['completed']:.3f}, coverage {summary['coverage']:.4f}, Q {summary['Q']:.3f} "
          f"({summary['seconds']:.0f} s)")


if __name__ == "__main__":
    for kind, size in RUNS:
        run(kind, size)
