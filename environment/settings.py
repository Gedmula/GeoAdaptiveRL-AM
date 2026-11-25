"""Constants of the toolpath environment, as the reported policy was trained and tested with."""

# === GEOMETRY ===
CELL_MM = 0.1                    # One grid cell.
MIN_GRID = 100                   # Smaller grids are padded to this size.

# === DEPOSITION ===
BEAD_WIDTH = 4.5                 # Cells.
BEAD_ELONGATION = 1.2            # Oval stretch along the move.
COVERAGE_DONE = 0.3              # A part cell is covered at this accumulation.
OVERLAP_LIMIT = 3.0              # A part cell is overfilled above this.
OVERLAP_GRACE = 1.2              # Extra overlap a continuing bead may reach.
SPILL_LIMIT = 0.5                # A non-part cell is spilled at this accumulation.
SPACING_MIN = 3.0                # Cells from the nearest finished bead for a new bead.
SPACING_CAP = 10.0               # Spacing is measured up to this distance.
CONTINUE_MULT = 0.45             # Material share of a deposit that extends a bead.
BEAD_PITCH = 4.0                 # Cells between neighbouring rows of the reference raster.

# === MOTION (step clock and reference raster) ===
PRINT_SPEED = 15.0               # mm/s
PRINT_ACCEL = 1000.0             # mm/s^2
TRAVEL_SPEED = 30.0              # mm/s
TRAVEL_ACCEL = 1250.0            # mm/s^2
RETRACT_TIME = 0.05              # s, when a bead ends.
PRIME_TIME = 0.05                # s, when a bead starts.
MASS_X = 1.0                     # Axis weights of the raster cost.
MASS_Y = 1.25
COAST_COST = 0.25                # Weight of the distance an axis moves at cruise speed.
TIME_COST = 10.5                 # Raster cost per second.

# === EPISODE LIMITS ===
LIMITS = {
    "done_coverage": 0.98,       # Completed at this coverage ...
    "done_max_void": 16,         # ... with no uncovered cluster larger than this (cells).
    "budget_factor": 6.0,        # Step budget = budget_factor x reference print steps
    "budget_travel": 4.0,        #               + budget_travel x N.
    "stall_factor": 2.0,         # Ends after max(stall_factor x N, stall_min) steps without new coverage.
    "stall_min": 200,
}

# === PRINTABLE VOIDS ===
# From VOID_RULE_COVERAGE on, uncovered part cells with at most 2 x VOID_LINK covered cells
# between them form one cluster. A cluster is unprintable when it has fewer than VOID_MIN_CELLS
# cells or no cell where a new bead may start lies within VOID_REACH cells of it, unless the
# open bead can sweep into it. The episode ends as "stranded" when no printable cluster is left.
VOID_RULE_COVERAGE = 0.85
VOID_LINK = 1
VOID_MIN_CELLS = 3
VOID_REACH = 3

# === REWARD ===
# Step terms are normalised by the part (part cells G, reference print steps S_part); the edge
# and revisit penalties by the grid scale (N / REWARD_GRID)^2.
REWARD_GRID = 100
REWARD = {
    "alpha_cover": 10.0,         # Episode total = alpha_cover x final coverage.
    "alpha_spill": 10.0,         # Per non-part cell spilled.
    "alpha_overfill": 10.0,      # Per part cell overfilled.
    "bead_start_cells": 10.0,    # A bead start costs the coverage value of this many cells.
    "alpha_travel": 2.0,         # Episode total = alpha_travel x travel steps / S_part.
    "alpha_time": 1.0,           # Episode total = alpha_time x steps / S_part.
    "alpha_boundary": 0.1,       # Per move into the grid edge.
    "alpha_oscillation": 0.05,   # Per move back onto a cell visited within oscillation_window steps.
    "oscillation_window": 8,
    "alpha_done": 10.0,          # Completion bonus.
    "alpha_quality": 15.0,       # x layer quality Q.
    "alpha_fail": 10.0,          # Ending without completion; the episode totals -alpha_fail x sqrt(1 - coverage).
    "alpha_stranded": 1.0,       # Per cell the agent stranded, in coverage value.
    "quality_weights": (0.35, 0.25, 0.15),   # voids, beads, material
    "void_tolerance_beads": 4.0, # The largest void is graded against this x BEAD_WIDTH^2 cells.
    "bead_scale": 10.0,          # Extra beads that halve the bead score.
}

# === OBSERVATIONS ===
LOCAL_RADIUS = 16                # 33 x 33 local map around the nozzle.
GLOBAL_SIZE = 32                 # Whole layer downsampled to 32 x 32.
LOCAL_CHANNELS = 7
GLOBAL_CHANNELS = 5
PREVIEW_FEATURES = 11
RAY_SCALE = 16.0
STATE_FEATURES = 38
