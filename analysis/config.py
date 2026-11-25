"""Paths and settings shared by the analysis scripts."""

import math
import os

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

SLICES = os.path.join(ROOT, "slices")
RL_GCODE = os.path.join(ROOT, "gcode", "rl_test_layers")
BASELINE_GCODE = os.path.join(ROOT, "gcode", "baselines_prusaslicer_100pct")
RAW = os.path.join(ROOT, "results", "raw", "rl_test_layers")
RAW_TRAIN = os.path.join(ROOT, "results", "raw", "rl_train_layers_generalization")
PROCESSED = os.path.join(ROOT, "results", "processed")
REPRODUCED = os.path.join(ROOT, "results", "reproduced")
TRAINING_LOGS = os.path.join(ROOT, "training_logs")

TEST_SIZES = (100, 200, 400, 500)
TRAIN_SIZES = (100, 200, 400)
COMPARISON_SIZE = 500

SOLID = ("rectilinear", "concentric", "hilbertcurve", "archimedeanchords", "octagramspiral")
CLASSES = ("simple", "moderate", "complex", "very_complex", "extreme")
CLASS_BOUNDS = (1.25, 1.75, 2.5, 4.0, math.inf)       # Upper bound of the complexity ratio per class.

CELL_MM = 0.1
LAYER_HEIGHT_MM = 0.2
NOZZLE_MM = 0.4
FILAMENT_MM = 1.75
LINE_MM = 0.45
ROUNDING_MM = LAYER_HEIGHT_MM * (1 - math.pi / 4)     # Width the rounded bead sides add to A / h.

# Machine model used to time every toolpath.
MACHINE = {"nozzle_diameter_mm": NOZZLE_MM, "max_acceleration": 3000.0,
           "force_print_feedrate": 3600.0, "force_travel_feedrate": 9000.0}

MIN_COVERAGE = 90.0          # RL layers below this coverage (%) are left out of the paired tests.
WORKERS = max(1, (os.cpu_count() or 2) - 2)


def grid(size):
    return f"{size}x{size}"


def test_folder(size):
    return os.path.join(SLICES, "test", grid(size))


def train_folder(size):
    return os.path.join(SLICES, "train", grid(size))


def output(*parts):
    """Path of an output file under results/reproduced/ (folder created)."""
    path = os.path.join(REPRODUCED, *parts)
    os.makedirs(os.path.dirname(path), exist_ok=True)
    return path


PUBLISHED_INPUTS = False         # True: the statistics scripts read their input tables from results/processed/ only.


def source(*parts):
    """An input table: the reproduced one if it exists, otherwise the published one."""
    path = os.path.join(REPRODUCED, *parts)
    if PUBLISHED_INPUTS or not os.path.exists(path):
        return os.path.join(PROCESSED, *parts)
    return path
