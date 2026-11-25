"""Compare reproduced rollouts (run_policy.py) with the published ones in results/raw/.

Per layer: the path and the actions must be identical, the metrics equal within 1e-9.

    python environment/compare_rollouts.py
"""

import glob
import json
import math
import os

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.dirname(HERE)
REPRODUCED = os.path.join(ROOT, "results", "reproduced", "rollouts")
PUBLISHED = {"test": os.path.join(ROOT, "results", "raw", "rl_test_layers"),
             "train": os.path.join(ROOT, "results", "raw", "rl_train_layers_generalization")}


def same(a, b):
    if isinstance(a, dict):
        return all(same(a[k], b.get(k)) for k in a)
    if isinstance(a, (int, float)) and isinstance(b, (int, float)) and not isinstance(a, bool):
        return math.isclose(a, b, rel_tol=1e-9, abs_tol=1e-12)
    return a == b


def compare(run):
    kind, grid = run.split("_", 1)
    base = os.path.join(REPRODUCED, run)
    files = sorted(glob.glob(os.path.join(base, "**", "json", "*_path.json"), recursive=True))
    differ = []
    for path in files:
        rel = os.path.relpath(path, base)
        published = os.path.join(PUBLISHED[kind], grid, rel)
        if not os.path.exists(published):                       # Sets without class subfolders.
            published = os.path.join(PUBLISHED[kind], grid, "json", os.path.basename(path))
        new, old = json.load(open(path)), json.load(open(published))
        problems = []
        if new["path"] != old["path"]:
            problems.append("path")
        metrics = {k: v for k, v in new["performance_metrics"].items() if k in old["performance_metrics"]}
        if not same(metrics, old["performance_metrics"]):
            problems.append("metrics")
        actions = path.replace(f"{os.sep}json{os.sep}", f"{os.sep}actions{os.sep}").replace("_path.json", "_actions.txt")
        old_actions = os.path.join(os.path.dirname(os.path.dirname(published)), "actions", os.path.basename(actions))
        if os.path.exists(old_actions) and open(actions).read().split() != open(old_actions).read().split():
            problems.append("actions")
        if problems:
            differ.append(f"{rel}: {', '.join(problems)}")
    print(f"{run}: {len(files)} layers, {len(files) - len(differ)} identical")
    for d in differ:
        print("   ", d)


if __name__ == "__main__":
    for run in sorted(os.listdir(REPRODUCED)) if os.path.isdir(REPRODUCED) else []:
        compare(run)
