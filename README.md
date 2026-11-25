# GeoAdaptiveRL-AM: data, logs and results

This repository is the public data record for the article *A Reinforcement Learning Framework for Objective-Oriented Geometry‑Adaptive Toolpaths in Additive Manufacturing*.
It holds the data the article reports on: the layer slices the agent was trained and tested on, the trained policies and their training logs, every G-code toolpath used in the results (RL, PrusaSlicer baselines and the printed lattice parts), the raw per-layer outputs of the policy, and the processed tables behind the figures and statistics.

The agent is a PPO policy (Stable-Baselines3) that plans an FDM toolpath for one layer on a grid of 0.1 mm cells. At each step it moves one cell in one of 8 directions, and the environment decides whether that step deposits material. 

**Reported policy:** `models/stage3_400x400/best_model.zip` (125,000,448 timesteps), run from the bottom-left corner. Every RL result in this repository comes from this file.

---

## Contents at a glance

| Folder | What it holds | Files |
|---|---|---:|
| [`slices/`](slices) | Train and test layer masks (PNG) with manifests | 18,657 |
| [`models/`](models) | `best_model.zip` and configuration of each curriculum stage of the training run | 12 |
| [`training_logs/`](training_logs) | TensorBoard event files of each stage, plus the training series used in the article | 4 |
| [`gcode/`](gcode) | **All toolpath G-code**: RL on the test layers, PrusaSlicer baselines, lattice parts (with their slice tables) | 3,595 |
| [`RL_toolpaths_500x500/`](RL_toolpaths_500x500) | RL toolpath images on the 500×500 test slices: the agent's raw path against the processed G-code | 400 |
| [`results/raw/`](results/raw) | Per-layer policy outputs (action sequences, paths, raw-path images, metrics) | 5,194 |
| [`results/processed/`](results/processed) | Tables behind the figures and statistics of the article | 29 |
| [`analysis/`](analysis) | Python scripts that recompute the processed results | 15 |
| [`environment/`](environment) | The toolpath environment and a script that runs the reported policy | 7 |
| [`figures/`](figures) | Scripts that draw the result figures of the article (Figures 7–18), with the lattice models and print photographs they use | 18 |

```
GeoAdaptiveRL-AM/
├── slices/
│   ├── train/{100x100,200x200,400x400}/
│   └── test/{100x100,200x200,400x400,500x500}/
├── models/{stage1_100x100,stage2_200x200,stage3_400x400}/
├── training_logs/{stage1_100x100,stage2_200x200,stage3_400x400}/ + training_series.csv
├── gcode/
│   ├── rl_test_layers/{100x100,200x200,400x400,500x500}/<class>/
│   ├── baselines_prusaslicer_100pct/<pattern>/<class>/
│   └── lattices/{schwarz_p_single_cell,schwarz_p_3x3x3}/{full_part,single_layer}/
├── RL_toolpaths_500x500/<class>/
└── results/
    ├── raw/
    │   ├── rl_test_layers/{100x100,200x200,400x400,500x500}/
    │   └── rl_train_layers_generalization/{100x100,200x200,400x400}/
    └── processed/{baseline_comparison,transfer,generalization,coverage_fill}/
├── analysis/
├── environment/
└── figures/
```

### Complexity classes

Layers are grouped by the complexity ratio CR = P / (2·√(π·A)), where P is the perimeter and A the area of the layer. A disc has CR = 1.

| Folder | Class | CR range |
|---|---|---|
| `1_simple` | Simple | CR < 1.25 |
| `2_moderate` | Moderate | 1.25 ≤ CR < 1.75 |
| `3_complex` | Complex | 1.75 ≤ CR < 2.5 |
| `4_very_complex` | Very complex | 2.5 ≤ CR < 4 |
| `5_extreme` | Extreme | CR ≥ 4 |

Layer files keep the same name everywhere. For example, `image_42` is the same layer in `slices/test/500x500/`, `gcode/rl_test_layers/500x500/`, `gcode/baselines_prusaslicer_100pct/<pattern>/`, `RL_toolpaths_500x500/` and `results/raw/rl_test_layers/500x500/`.

---

## 1. Slices — `slices/`

Binary layer masks: white marks the material to be deposited. One pixel is one 0.1 mm grid cell, so a 500×500 mask covers 50 × 50 mm.

| Set | Grid sizes | Layers |
|---|---|---|
| `train/` | 100×100, 200×200, 400×400 | 4,208 / 6,346 / 6,434 (as listed in each `placement_summary.txt`) |
| `test/` | 100×100, 200×200, 400×400, 500×500 | 380 / 400 / 400 / 400 |

- `manifest.csv` in each folder (and in each class subfolder where present) describes every layer. Its columns include the source (`procedural`, `stl` or `complex`), difficulty level, placement on the bed, the source STL and slice height where applicable, fill fraction, islands, holes, area (mm²), perimeter (mm), complexity ratio and complexity class.
- `placement_summary.txt` summarises the placement statistics of each set.

The models were trained on `train/` only. The 500×500 test layers are larger than any training grid.

---

## 2. Models and training logs — `models/`, `training_logs/`

The policy was trained in one run with a grid-size curriculum of 100 → 200 → 400 cells. Each stage resumed from the previous one and moved on once completion was at least 90% and the bead and travel metrics stopped improving (`size_switch.json`).

| Stage | Original run name | Grid | Cumulative timesteps at end of stage |
|---|---|---|---|
| `stage1_100x100` | `PPO_v2_100x100_20261030_0943` | 100×100 | 55,000,176 |
| `stage2_200x200` | `PPO_v2_200x200_20261030_1658` | 200×200 | 100,000,344 |
| `stage3_400x400` | `PPO_v2_400x400_20261031_0206` | 400×400 | 135,000,480 (best model at 125,000,448) |

Each `models/<stage>/` folder contains:

| File | Content |
|---|---|
| `best_model.zip` | Stable-Baselines3 PPO policy: the best checkpoint of that stage by periodic evaluation on held-out layers. Loading it with `PPO.load(...)` requires the feature extractor class in `environment/MapExtractor.py` (section 8). The stage 1–3 best models were used for the train/test generalization results. |
| `training_config.json` | Full configuration: PPO hyperparameters, network, reward weights, termination limits, curriculum and evaluation layers |
| `curriculum.json` | Curriculum stage switches within the run |
| `size_switch.json` | The criterion values when the run moved to the next grid size |

`training_logs/<stage>/events.out.tfevents.*` are the TensorBoard logs. Open them with `tensorboard --logdir training_logs`. `training_logs/training_series.csv` is the series exported from these logs for the training figure in the article.

Main hyperparameters (stage 3): 24 parallel environments, `n_steps` 4096, batch 16,384, 5 epochs, γ = 0.99994, GAE λ = 0.98, entropy coefficient 0.0025, clip 0.2, learning rate 1e-4 → 5e-5, seed 0.

---

## 3. G-code — `gcode/`

All toolpaths are Marlin-flavour G-code for a Prusa MK4 (0.4 mm nozzle, 0.2 mm layer height, PLA).

### 3.1 RL toolpaths on the test layers — `gcode/rl_test_layers/`

These are the G-code files of the reported policy on all four test sets: one file per layer (`image_<n>.gcode`) for 1,580 layers. They were generated from the agent's path (`results/raw/.../json/*_path.json`) with a **0.45 mm line width**, the setting used in the article. Other settings:

- simplified travels and merged collinear moves, with a smoothing tolerance of 0.5 cells
- retraction of 0.7 mm before travels of 1.5 mm or more
- Y pointing up the bed

`400x400/` has no class subfolders, because that test set was not split by class.

### 3.2 Baseline toolpaths — `gcode/baselines_prusaslicer_100pct/`

These are the PrusaSlicer toolpaths RL is compared with in the article: **five solid (100% infill) patterns**, archimedeanchords, concentric, hilbertcurve, octagramspiral and rectilinear. There are 400 files per pattern, named `image_<n>_<pattern>.gcode`, and sorted by class.

- PrusaSlicer 2.9.6, `MK4IS_0.20mm_SPEED` profile
- 100% fill density, no perimeters, no top or bottom solid layers, no skirt, arc fitting off, `--dont-arrange`
- Each 500×500 test mask was extruded into a 3-layer prism (0.2 mm layers) and sliced. The file kept is **layer 2**, so the first layer has no effect.
- `generation_manifest.json` records the exact command-line settings and the number of layers per pattern.

### 3.3 Lattice parts — `gcode/lattices/`

These are the multi-layer parts printed with the RL policy and shown in the article. The policy planned every slice of each part.

| Folder | Part | Files |
|---|---|---|
| `schwarz_p_single_cell/` | Schwarz-P lattice, single unit cell | `full_part/schwarz_p_greedy.gcode` (whole part), `single_layer/schwarz_p_layer_25.gcode` (largest slice printed alone) |
| `schwarz_p_3x3x3/` | Schwarz-P lattice, 3×3×3 unit cells | `full_part/schwarz_p_3x3x3_greedy.gcode`, `single_layer/schwarz_p_3x3x3_layer_63.gcode` |

In each part folder:

| File | Content |
|---|---|
| `full_part/gcode_summary.json` | The part's G-code per layer and in total (print and travel length, retractions, extrusion paths, coverage) |
| `slices/manifest.csv` | Every 0.2 mm slice of the part on 0.1 mm cells: height, area, cells, islands, holes, and `same_as` for a slice identical to an earlier one |
| `slices/complexity.csv`, `complexity_summary.csv` | Complexity ratio and class of every slice, and per part |
| `slices/slicing.json` | Grid and placement of the part |

### 3.4 Path comparison images (500×500) — `RL_toolpaths_500x500/`

Each of the 400 images, `image_<n>_path_comparison.png`, draws the reported policy's toolpath on its 500×500 test slice in two panels. On the left is the **original path**, the agent's cell-by-cell rollout. On the right is the **processed path** written to the G-code in `gcode/rl_test_layers/500x500/`, after travels are simplified, collinear moves merged and the path smoothed. Deposition is drawn in blue, travel in red and the slice boundary in black. Axes are grid cells (0.1 mm). Each panel title gives the point count, and the processed panel also gives the number of print moves and the coverage reached. The images are sorted by complexity class. These images exist only for the 500×500 test set, the one used in the article's main comparison.

---

## 4. Raw results — `results/raw/`

### 4.1 Policy on the test layers — `results/raw/rl_test_layers/<grid>/`

This folder holds the output of the reported policy (greedy, seed 0) on every test layer. The G-code for these runs is in `gcode/rl_test_layers/`.

| Item | Content |
|---|---|
| `<class>/actions/image_<n>_actions.txt` | The action sequence, one integer per line: 0 N, 1 S, 2 W, 3 E, 4 NW, 5 NE, 6 SW, 7 SE |
| `<class>/json/image_<n>_path.json` | The full rollout. `path` is a list of `[row, col, deposit]` cells. The file also holds `grid_info` (shape, 0.1 mm cell size), completion and path statistics, all `performance_metrics`, and `execution_stats` (model file and modification time, seed, wall time). |
| `<class>/images/` | Rendered raw paths: `*_raw_path.png` (`*_path.png` at 400×400). The 500×500 path comparison images are in `RL_toolpaths_500x500/`. |
| `metrics.csv` | One row per layer, with the layer descriptors and every environment metric (outcome, coverage, steps, travel, beads, voids, spill, print time and the quality scores Q, q_void, q_bead, q_material) |
| `summary.json` | Set averages and the evaluation settings |
| `batch_summary_*.xlsx`, `processing_summary.json` | Batch reports from the run, including the G-code conversion at 500×500 |

The 400×400 set has no class subfolders (`json/` and `images/` sit directly in the folder) and no `actions/` folder.

### 4.2 Policy on training layers — `results/raw/rl_train_layers_generalization/<grid>/json/`

These are path JSONs (same format as above) from rollouts on a sample of training layers at each grid size. They were used for the train/test generalization comparison (`results/processed/generalization/`).

---

## 5. Processed results — `results/processed/`

| Folder | Content |
|---|---|
| `baseline_comparison/` | **Main comparison of RL with the five solid PrusaSlicer patterns** on the 500×500 test layers |
| `transfer/` | How the policy transfers across the four test grid sizes |
| `generalization/` | Train vs test performance at each grid size |
| `coverage_fill/` | Agreement between the coverage the environment reports and the fill of the deposited G-code |

### 5.1 `baseline_comparison/`

| File | Content |
|---|---|
| `per_slice_metrics.csv` | One row per layer and toolpath. It covers print time (trapezoidal profile, as in the article, and a planner that also slows down at corners), travel, extrusion starts, retractions, bead length, direction changes, fill, overspill, over-deposition, Dice, voids and edge fill. Deposition is computed with the bead-sweep method. |
| `per_slice_metrics_raster.csv` | The same table with deposition computed on a raster (not reported in the article) |
| `summary_by_class.csv` | Medians and quartiles per toolpath and complexity class |
| `paired.csv` | RL against each pattern, paired over layers: Hodges–Lehmann estimate with a 95% CI, Wilcoxon signed-rank test with Holm correction, and the verdict (superior / inferior / equivalent / inconclusive) |
| `paired_all_slices.csv` | The same comparison without excluding low-coverage layers (not reported in the article) |
| `paired_junction.csv` | The print-time comparison with the planner that slows down at corners (per-axis jerk 8 mm/s; not reported in the article) |
| `friedman.csv`, `ranks.csv` | Friedman test with Kendall's W, and mean ranks per class |
| `profiles.csv` | Dolan–Moré performance profiles |
| `pareto.csv` | Share of layers on the Pareto front (time, starts, unfilled share) |
| `exclusions.csv` | Layers left out because RL coverage was below 90% (5 of 400, all in the extreme class) |
| `settings.json`, `sweep_settings.json` | Evaluation settings: feed rates (print 3600 and travel 9000 mm/min, acceleration 3000 mm/s²), 0.45 mm line width and bead sweep |

Note: the per-layer and per-class tables also have rows for three sparse PrusaSlicer patterns (gyroid, honeycomb and triangles at 90% infill; PrusaSlicer does not slice these at 100%). These rows are descriptive only. The sparse patterns are **not** part of the statistical comparison, and their G-code is not included.

### 5.2 Other folders

- `transfer/transfer_per_layer.csv`: policy outcome and metrics for every test layer at every grid size. `transfer.csv` summarises it per size and class, and `transfer_fits.csv` holds the logistic and LOESS fits of completion and quality against CR.
- `generalization/train_<grid>/metrics.csv`, `sample.csv`: metrics on the training-layer sample and the sample definition. `train_test_gap.csv` holds the gap tests (CMH / van Elteren, Holm-corrected). `train_test_summary.csv` and `scale.csv` give summaries per grid size.
- `coverage_fill/coverage_fill.csv`: rollout coverage and G-code fill of every test slice, the fill measured by bead sweeping as in the article. `summary.csv` gives their agreement per grid size and class (fill − coverage: median, quartiles, bias, 95% limits of agreement, share within 1 and 3 pp). `coverage_fill_raster.csv` and `coverage_fill_raw.csv` hold the same slices with the fill computed on a raster, where a cell is filled when half of it is covered (not reported in the article).

---

## 6. Analysis code — `analysis/`

These scripts recompute the processed results from the slices, the rollouts in `results/raw/` and the G-code in `gcode/`. Tested with Python 3.13; install the packages with `pip install -r analysis/requirements.txt`. Run them from the repository root.

| Script | Reads | Writes |
|---|---|---|
| `path_to_gcode.py` | one `*_path.json` | the RL G-code of that layer (0.45 mm line), as in `gcode/rl_test_layers/` |
| `coverage_fill.py` | path JSONs and RL G-code of the four test sets | `coverage_fill/` |
| `evaluate_toolpaths.py` | RL and baseline G-code of the 500×500 test set | `baseline_comparison/per_slice_metrics*.csv`, `settings.json` |
| `baseline_statistics.py` | `per_slice_metrics.csv`, `coverage_fill.csv` | the other tables of `baseline_comparison/` |
| `transfer.py` | `results/raw/rl_test_layers/<grid>/metrics.csv` | `transfer/` |
| `generalization.py` | `transfer_per_layer.csv`, training manifests, `train_<grid>/metrics.csv` | `generalization/` (`sample.csv` included) |
| `training_series.py` | `training_logs/` | `training_series.csv` |
| `compare.py` | | compares every reproduced table with the published one |

The other modules hold the shared code: G-code parsing and timing (`gcode.py`), raster and bead-sweep deposition (`deposition.py`, `bead_sweep.py`), the toolpath metrics (`toolpath_metrics.py`), slice complexity (`layers.py`) and paths and settings (`config.py`).

Outputs go to `results/reproduced/`, with the same layout as `results/processed/`, so the published tables are never overwritten. A script reads its input tables from `results/reproduced/` when they exist there, otherwise from `results/processed/`; with `PUBLISHED_INPUTS = True` in `config.py` it always reads the published ones. Each script's options are settings at the top of the file. To recompute everything:

```
python analysis/coverage_fill.py
python analysis/evaluate_toolpaths.py
python analysis/baseline_statistics.py
python analysis/transfer.py
python analysis/generalization.py
python analysis/training_series.py
python analysis/compare.py
```

`coverage_fill.py` and `evaluate_toolpaths.py` measure about 4,000 G-code files and together take about 15 minutes on 18 cores (`config.WORKERS`). The statistics scripts take a few minutes.

`evaluate_toolpaths.py` covers RL and the five solid patterns only, so its tables have no rows for the three sparse patterns. With `REGENERATE_GCODE = True`, `coverage_fill.py` first rewrites the RL G-code from the path JSONs into `results/reproduced/gcode_rl/` and measures those files.

---

## 7. Figures — `figures/`

These scripts draw the result figures of the article into `results/reproduced/figures/Fig <n>.pdf/.png/.tif`, in the article's style (Arial, 600 dpi). Install the packages with `pip install -r figures/requirements.txt`.

| File | Content |
|---|---|
| `results_figures.py` | Figures 7–13: bead-sweep schematic, generalization, coverage against fill, toolpath medians, paired differences, deposited regions of three slices, paired differences per class. From `results/processed/`, the 500×500 test slices and the G-code |
| `lattice_figures.py` | Figures 14–18: the two Schwarz-P lattices, the printed layers 25 and 63 against their G-code, and the printed parts. From `gcode/lattices/` and `figures/inputs/` |
| `style.py` | The figure style. Text that would print below 6.5 pt at the figure's width in the article is set to 6.6 pt, as in the article |
| `inputs/stl/` | The lattice models: `schwarz_p.stl` (single cell, 40 mm unit cell, 2.6 mm wall) and `schwarz_p_3x3x3.stl` (3×3×3 unit cells, 1.35 mm walls), both in the 50 mm cube |
| `inputs/outlines/` | The slice outlines (mm) of layer 25 of the single-cell lattice and layer 63 of the multi-cell lattice |
| `inputs/photos/` | Photographs and video frames of the printed layers and parts (camera metadata removed) |

`FIGURES` at the top of each script selects the figures. Rendered with these scripts, every figure matches the image in the article. Figure 14 is drawn with pyvista off screen, so its shading can depend on the graphics driver.

```
python figures/results_figures.py
python figures/lattice_figures.py
```

---

## 8. Environment and policy rollouts — `environment/`

This is the toolpath environment the reported policy was trained and tested in, with the settings of that policy, and a script that runs the policy on the slices. Install the packages with `pip install -r environment/requirements.txt`.

| File | Content |
|---|---|
| `toolpath_env.py` | The environment (Gymnasium): one layer on a grid of 0.1 mm cells, 8 move actions, the deposition rule that decides whether a step prints, observations, reward and episode end |
| `settings.py` | Its constants: bead stamp and deposition limits, motion, episode limits, void rule, reward weights, observation sizes |
| `kinematics.py` | The step clock (print time) and the reference raster that sets `S_part` |
| `MapExtractor.py` | The feature extractor of the policy network; the saved model refers to it by this module name |
| `run_policy.py` | Runs `models/stage3_400x400/best_model.zip` with greedy actions on a test set, or on the training-layer sample of the generalization comparison |
| `compare_rollouts.py` | Compares the rollouts with those in `results/raw/` |

Every episode starts at the bottom-left corner of the grid and ends on completion, when only unprintable voids are left, on the step budget or after a stall.

```
python environment/run_policy.py
python environment/compare_rollouts.py
```

`RUNS` at the top of `run_policy.py` lists the sets to run: every test set and the three training samples by default. Each run writes `json/*_path.json` and `actions/*_actions.txt` per layer, `metrics.csv` and `summary.json` to `results/reproduced/rollouts/<test|train>_<grid>/`, in the format of `results/raw/`. The path JSONs can be turned into G-code with `analysis/path_to_gcode.py`. Running all four test sets takes about 20 CPU-hours, mostly the 400×400 and 500×500 layers; `LIMIT` runs only the first layers of each set, and `WORKERS` sets the parallel processes (each holds its own copy of the model, about 0.5–1 GB of memory).

---

## 9. Mapping to the original project paths

Settings files and JSONs keep the paths of the original working project. This table maps them to this repository.

| Original path | This repository |
|---|---|
| `Grid Folders/Train layers v2/<grid>` | `slices/train/<grid>` |
| `Grid Folders/Test layers v2/<grid>` | `slices/test/<grid>` |
| `Model_results/PPO_v2_100x100_20261030_0943` | `models/stage1_100x100` |
| `Model_results/PPO_v2_200x200_20261030_1658` | `models/stage2_200x200` |
| `Model_results/PPO_v2_400x400_20261031_0206` | `models/stage3_400x400` |
| `Training_logs/PPO_v2_<grid>_<date>_<n>` | `training_logs/stage<k>_<grid>` |
| `Model_results/PPO_v2_400x400_20261031_0206/test_Test_layers_v2_<grid>_greedy/**/gcode_w045` | `gcode/rl_test_layers/<grid>` |
| `Model_results/PPO_v2_400x400_20261031_0206/test_Test_layers_v2_500x500_greedy/<class>/images/*_path_comparison.png` | `RL_toolpaths_500x500/<class>` |
| `Model_results/PPO_v2_400x400_20261031_0206/test_Test_layers_v2_<grid>_greedy` (everything else) | `results/raw/rl_test_layers/<grid>` |
| `Baseline Folders/Test layers v2 500x500/solid100/layers` | `gcode/baselines_prusaslicer_100pct` |
| `RL_outputs/Lattice_j/schwarz_p/schwarz_p` | `gcode/lattices/schwarz_p_single_cell` |
| `RL_outputs/Lattice_j/schwarz_p_cells/schwarz_p_3x3x3` | `gcode/lattices/schwarz_p_3x3x3` |

---
