"""Toolpath environment: one FDM layer on a grid of 0.1 mm cells.

Actions are Discrete(8) moves of one cell: 0 N, 1 S, 2 W, 3 E, 4 NW, 5 NE, 6 SW, 7 SE. The
nozzle starts at the bottom-left corner of the (padded) grid. The agent only moves; the
deposition rule decides whether a step prints:
  - an oval bead stamp is laid along the move, and a part cell is covered once its
    accumulated material reaches COVERAGE_DONE
  - a deposit is refused when it would spill too far past the part boundary or overfill
    cells, and a deposit that would cover no new part cell is not made
  - a bead continues while the nozzle stays next to its last deposit; a new bead may not
    start within SPACING_MIN cells of a finished bead
  - a move off the grid does nothing and is penalised

Observations (gymnasium Dict):
  local_map       7 x 33 x 33 around the nozzle: uncovered part, fill, non-part, outside the
                  grid, finished beads, cells where a bead may start, the open bead
  global_map      5 x 32 x 32 of the whole layer: uncovered part, covered part, nozzle, cells
                  where a bead may start, printable voids
  action_preview  8 x 11, per action: prints, starts a bead, new covered / spilled / overfilled
                  cells, an unused column (0), hits the edge, revisits a recent cell, and along a
                  ray to the grid edge: printable void cells, distance to the first, the straight
                  run of printable void from there
  state           38 values: coverage, steps used, heading, bead and run state, travel, the
                  nearest printable void, clusters, position, grid size, the completion limits,
                  the reward weights in force and the gap to completion

An episode ends on completion (coverage >= 98 % with no uncovered cluster above 16 cells),
when only unprintable voids are left ("stranded"), on the step budget, or after a stall.
"""

import math
import os
from collections import deque

import cv2
import gymnasium as gym
import numpy as np
from gymnasium import spaces
from PIL import Image
from scipy import ndimage

import kinematics as K
import settings as C

# [dy, dx] per action.
DIRECTIONS = np.array([[-1, 0], [1, 0], [0, -1], [0, 1],
                       [-1, -1], [-1, 1], [1, -1], [1, 1]], dtype=np.int64)
DIRECTION_TUPLES = [tuple(int(v) for v in d) for d in DIRECTIONS]
OUTSIDE = -2                     # Cell value beyond the grid edge.
EIGHT = np.ones((3, 3), dtype=bool)


# ========================================================================
# BEAD STAMP
# ========================================================================

def oval_stencil(direction):
    """(dy, dx, material) of the oval bead laid moving in `direction`."""
    move_vec = DIRECTIONS[direction]
    base = C.BEAD_WIDTH
    width = height = base
    if direction in (0, 1):
        height, rotation = base * C.BEAD_ELONGATION, 0.0
    elif direction in (2, 3):
        width, rotation = base * C.BEAD_ELONGATION, 0.0
    elif direction in (4, 7):
        height, rotation = base * C.BEAD_ELONGATION, -np.pi / 4
    else:
        height, rotation = base * C.BEAD_ELONGATION, np.pi / 4
    a, b = width / 2.0, height / 2.0
    ext = int(np.ceil(max(a, b)))
    cos_r = np.cos(-rotation) if rotation != 0.0 else 1.0
    sin_r = np.sin(-rotation) if rotation != 0.0 else 0.0
    move_unit = move_vec.astype(float) / np.linalg.norm(move_vec)
    perp_unit = np.array([-move_unit[1], move_unit[0]])
    out = []
    for dy in range(-ext, ext + 1):
        for dx in range(-ext, ext + 1):
            if rotation != 0.0:
                dx_rot, dy_rot = dx * cos_r - dy * sin_r, dx * sin_r + dy * cos_r
            else:
                dx_rot, dy_rot = dx, dy
            oval_dist = dx_rot ** 2 / a ** 2 + dy_rot ** 2 / b ** 2
            if oval_dist > 1.0:
                continue
            if oval_dist <= 0.16:
                base_cov = 2.0
            elif oval_dist <= 0.49:
                base_cov = 1.6
            elif oval_dist <= 0.81:
                base_cov = 1.2
            else:
                base_cov = 0.8
            pixel_vec = np.array([float(dy), float(dx)])
            mag = np.linalg.norm(pixel_vec)
            factor = 1.0
            if mag > 0.1:                    # Less material ahead of the nozzle and to the sides.
                pixel_unit = pixel_vec / mag
                forward = np.dot(pixel_unit, move_unit)
                side = abs(np.dot(pixel_unit, perp_unit))
                if forward < -0.3:
                    factor = 1.0 if side < 0.7 else 0.8
                elif forward < 0.3:
                    factor = 0.9 if side < 0.5 else 0.6
                else:
                    factor = 0.3 if side < 0.5 else 0.2
            value = base_cov * factor
            if value > 0.1:
                out.append((dy, dx, value))
    return np.array(out, dtype=np.float64)


def _stencil_table():
    stencils = [oval_stencil(d) for d in range(8)]
    k = max(len(s) for s in stencils)
    off_y = np.zeros((8, k), dtype=np.int64)
    off_x = np.zeros((8, k), dtype=np.int64)
    val = np.zeros((8, k), dtype=np.float64)
    mask = np.zeros((8, k), dtype=bool)
    for d, s in enumerate(stencils):
        n = len(s)
        off_y[d, :n], off_x[d, :n], val[d, :n], mask[d, :n] = s[:, 0], s[:, 1], s[:, 2], True
    return off_y, off_x, val, mask, k


OFF_Y, OFF_X, OVAL, OVAL_MASK, K_MAX = _stencil_table()
STENCIL_EXTENT = int(max(np.abs(OFF_Y).max(), np.abs(OFF_X).max()))


# ========================================================================
# LOOKUP TABLES
# ========================================================================

def _distance_window(radius):
    r = np.arange(-radius, radius + 1)
    return np.hypot(r[:, None], r[None, :])


SPACING_R = int(C.SPACING_CAP)
SPACING_DIST = _distance_window(SPACING_R)
SPACING_DISK = np.array([(dy, dx) for dy in range(-3, 4) for dx in range(-3, 4)
                         if math.hypot(dy, dx) < C.SPACING_MIN], dtype=np.int64)
LOCAL_DIST = _distance_window(C.LOCAL_RADIUS)
PAD = max(C.LOCAL_RADIUS, SPACING_R, STENCIL_EXTENT) + 1
LINK_KERNEL = np.ones((2 * C.VOID_LINK + 1,) * 2, dtype=np.uint8)
REACH_KERNEL = np.ones((2 * C.VOID_REACH + 1,) * 2, dtype=np.uint8)
_RAYS = {}


def ray_offsets(n):
    """(8, n, 3, 2) offsets of a 3-cell-wide band along each direction, steps 1..n."""
    if n not in _RAYS:
        k = np.arange(1, n + 1)
        out = np.zeros((8, n, 3, 2), dtype=np.int64)
        for d, (dy, dx) in enumerate(DIRECTION_TUPLES):
            for j, side in enumerate((-1, 0, 1)):
                out[d, :, j, 0] = k * dy - side * dx
                out[d, :, j, 1] = k * dx + side * dy
        _RAYS[n] = out
    return _RAYS[n]


def load_grid(path):
    """{0, 1} part mask of a layer image (white = part)."""
    img = np.array(Image.open(path).convert("L"))
    levels = np.unique(img)
    three_level = len(levels) >= 3 and np.any((levels > 100) & (levels < 180))
    return (img > (200 if three_level else 127)).astype(np.int8)


# ========================================================================
# ENVIRONMENT
# ========================================================================

class ToolpathEnv(gym.Env):
    """One layer. `grid` is a {0, 1} array (1 = part) or the path of a layer image."""

    metadata = {"render_modes": []}

    def __init__(self, grid):
        super().__init__()
        if isinstance(grid, (str, os.PathLike)):
            self.grid_file = str(grid)
            grid = load_grid(grid)
        else:
            self.grid_file = None
        grid = np.asarray(grid)
        if grid.ndim != 2 or not np.isin(grid, (0, 1)).all():
            raise ValueError("grid must be a 2-D array of 0 and 1")
        self.cfg = dict(C.REWARD)
        self.limits = dict(C.LIMITS)

        # === PADDED GRID AND MASKS ===
        # N = max(h, w, 100); -1 outside the image, 0 non-part, 1 part, the image centred.
        self.height, self.width = grid.shape
        n = max(self.height, self.width, C.MIN_GRID)
        self.N = n
        self.offset_height = (n - self.height) // 2
        self.offset_width = (n - self.width) // 2
        self.full_grid = np.full((n, n), -1, dtype=np.int8)
        self.full_grid[self.offset_height:self.offset_height + self.height,
                       self.offset_width:self.offset_width + self.width] = grid

        # Arrays carry PAD extra cells per side, so stamps and windows never clip.
        full = np.full((n + 2 * PAD, n + 2 * PAD), OUTSIDE, dtype=np.int8)
        full[PAD:PAD + n, PAD:PAD + n] = self.full_grid
        self.full = full
        self.goal = full == 1
        self.nonpart = (full == 0) | (full == -1)        # Spill counts here.
        self.outside = full == OUTSIDE
        in_image = np.zeros_like(self.goal)
        in_image[PAD + self.offset_height:PAD + self.offset_height + self.height,
                 PAD + self.offset_width:PAD + self.offset_width + self.width] = True
        # Cells inside the image next to the part: spill there weighs less in the rule.
        self.border = in_image & ndimage.binary_dilation(self.goal, EIGHT)
        self.border_factor = np.where(self.border, 0.3, 1.0)

        self._inner = (slice(PAD, PAD + n),) * 2
        self.goal_u8 = self.goal[self._inner].astype(np.uint8)
        self.rays = ray_offsets(n)
        self._cell_y, self._cell_x = (a.ravel().astype(np.float64) for a in np.indices((n, n)))

        # === PART SCALES AND LIMITS ===
        self.total_goals = int(self.goal.sum())
        if self.total_goals == 0:
            raise ValueError("grid has no part cells")
        self.islands = int(ndimage.label(self.goal, structure=EIGHT)[1])
        self.S_part = K.reference_print_steps(self.full_grid == 1, start=(n - 1, 0))
        lim = self.limits
        self.budget = int(lim["budget_factor"] * self.S_part + lim["budget_travel"] * n)
        self.stall_limit = int(max(lim["stall_factor"] * n, lim["stall_min"]))
        self.void_tolerance = self.cfg["void_tolerance_beads"] * C.BEAD_WIDTH ** 2
        self.grid_scale = (n / C.REWARD_GRID) ** 2

        # === SPACES ===
        self.action_space = spaces.Discrete(8)
        side = 2 * C.LOCAL_RADIUS + 1
        self.observation_space = spaces.Dict({
            "local_map": spaces.Box(0.0, 1.0, (C.LOCAL_CHANNELS, side, side), np.float32),
            "global_map": spaces.Box(0.0, 1.0, (C.GLOBAL_CHANNELS, C.GLOBAL_SIZE, C.GLOBAL_SIZE), np.float32),
            "action_preview": spaces.Box(0.0, 1.0, (8, C.PREVIEW_FEATURES), np.float32),
            "state": spaces.Box(-1.0, 1.0, (C.STATE_FEATURES,), np.float32),
        })
        self.clock = K.SegmentClock()
        self.reset()

    # ====================================================================
    # RESET
    # ====================================================================

    def reset(self, *, seed=None, options=None):
        super().reset(seed=seed)
        shape = self.full.shape
        self.cov = np.zeros(shape, dtype=np.float64)
        self.covered = np.zeros(shape, dtype=bool)
        self.spilled = np.zeros(shape, dtype=bool)
        self.overfilled = np.zeros(shape, dtype=bool)
        self.centerline = np.zeros(shape, dtype=bool)      # Centre lines of finished beads.
        self.start_blocked = np.zeros(shape, dtype=bool)   # Within SPACING_MIN of a finished bead.
        self.bead_map = np.zeros(shape, dtype=bool)        # Centre line of the open bead.
        self.uncovered = self.goal.copy()
        self.uncovered_f = self.uncovered[self._inner].astype(np.float32)
        self.covered_f = np.zeros((self.N, self.N), dtype=np.float32)

        self.n_covered = self.n_spilled = self.n_overfilled = 0
        self.bead_active = False
        self.bead_last = None
        self.bead_cells = []
        self.n_finished_beads = 0
        # Print runs as the G-code sees them: a bead is a run of printing steps.
        self.prev_printed = False
        self.run_length = 0
        self.run_lengths = []
        self.beads = 0

        self.pos = (self.N - 1, 0)                         # Bottom-left corner.
        self.heading = None
        self.clock.reset()
        self.steps = 0
        self.print_steps = 0
        self.travel_steps = 0
        self.blocked_steps = 0
        self.dry_steps = 0
        self.episode_path = []
        self.recent = deque([self.pos], maxlen=int(self.cfg["oscillation_window"]))
        self.oscillation_moves = 0
        self.reward_totals = dict.fromkeys(
            ("coverage", "spill", "overfill", "bead_start", "travel", "time",
             "boundary", "oscillation", "progress", "terminal", "stranded"), 0.0)
        self.total_reward = 0.0
        self._cluster_key = self._remaining_key = -1
        self._start_key = None
        self._preview_key = None
        self._void_key = self._base_key = self._printable_key = self._tour_key = None
        self._printable_pad = np.zeros(shape, dtype=bool)
        # Cells printable at the start: those the agent can strand.
        labels, sizes, _, n = self._void_clusters()
        self.printable0 = self._rule_flags(labels, sizes, n)[labels]
        return self._observation(), {"total_goals": self.total_goals, "budget": self.budget, "S_part": self.S_part}

    # ====================================================================
    # DEPOSITION RULE
    # ====================================================================

    def _spacing(self, py, px):
        """Distance to the nearest finished-bead cell, capped at SPACING_CAP."""
        win = self.centerline[py - SPACING_R:py + SPACING_R + 1, px - SPACING_R:px + SPACING_R + 1]
        return float(min(SPACING_DIST[win].min(), C.SPACING_CAP)) if win.any() else C.SPACING_CAP

    def _evaluate(self):
        """What each of the 8 actions would do from the current state, without changing it."""
        key = (self.steps, self.pos)
        if self._preview_key == key:
            return self._preview

        y, x = self.pos
        py, px = y + PAD, x + PAD
        iy, ix = py + OFF_Y, px + OFF_X
        full = self.full[iy, ix]
        valid = OVAL_MASK & (full != OUTSIDE)
        cov = self.cov[iy, ix]
        base = np.where(valid, OVAL, 0.0)
        potential = cov + base

        moves = np.array([(0 <= y + dy < self.N) and (0 <= x + dx < self.N) for dy, dx in DIRECTION_TUPLES])
        decide = np.zeros(8, dtype=bool)
        continues = np.zeros(8, dtype=bool)
        ends_bead = False

        # The nozzle must be over a part cell that is not already filled to 1.5 x the overlap limit.
        if self.full[py, px] == 1 and self.cov[py, px] < C.OVERLAP_LIMIT * 1.5:
            max_overlap = np.where(valid, potential, -np.inf).max(axis=1)
            rule_cells = valid & (full == 0)
            viol = rule_cells & (potential > C.SPILL_LIMIT)
            risk = np.where(viol, (potential - C.SPILL_LIMIT) * self.border_factor[iy, ix], 0.0)
            max_risk = risk.max(axis=1)
            n_viol = viol.sum(axis=1)
            n_border = (viol & self.border[iy, ix]).sum(axis=1)
            mostly_border = (n_viol > 0) & (n_border > 0.7 * np.maximum(n_viol, 1))
            void_risk = np.where(mostly_border, max_risk * 0.5, max_risk)

            if self.bead_active and self.bead_last is not None:
                ly, lx = self.bead_last
                ady, adx = abs(y - ly), abs(x - lx)
                if ady + adx > 0 and max(ady, adx) <= 1:            # Continue the open bead.
                    decide = (void_risk <= C.SPILL_LIMIT * 1.5) & (max_overlap < C.OVERLAP_LIMIT + C.OVERLAP_GRACE)
                    continues = decide.copy()
                else:
                    ends_bead = True                                 # Too far from the bead: it ends.
            elif self.n_finished_beads == 0:                         # First bead.
                decide = void_risk <= C.SPILL_LIMIT
            elif self._spacing(py, px) >= C.SPACING_MIN:             # New bead away from finished ones.
                decide = (void_risk <= C.SPILL_LIMIT) & (max_overlap < C.OVERLAP_LIMIT)
        decide &= moves

        mult = np.where(continues, C.CONTINUE_MULT, 1.0)[:, None]
        added = np.where(decide[:, None], base * mult, 0.0)
        new_cov = cov + added
        goal = full == 1
        new_covered = (valid & goal & ~self.covered[iy, ix] & (new_cov >= C.COVERAGE_DONE)).sum(axis=1)
        empty = decide & (new_covered == 0)                          # Would cover nothing: not made.
        decide &= ~empty
        continues &= decide
        added[~decide] = 0.0
        new_cov = cov + added
        nonpart = (full == 0) | (full == -1)
        new_covered = np.where(decide, new_covered, 0)
        new_spill = (valid & nonpart & ~self.spilled[iy, ix] & (new_cov >= C.SPILL_LIMIT)).sum(axis=1)
        new_over = (valid & goal & ~self.overfilled[iy, ix] & (new_cov > C.OVERLAP_LIMIT)).sum(axis=1)

        self._preview = {"moves": moves, "print": decide, "continues": continues,
                         "ends_bead": ends_bead, "empty": empty,
                         "new_covered": new_covered, "new_spill": new_spill, "new_over": new_over,
                         "iy": iy, "ix": ix, "valid": valid, "added": added}
        self._preview_key = key
        return self._preview

    def _end_bead(self):
        if self.bead_active and self.bead_cells:
            cells = np.array(self.bead_cells) + PAD
            self.centerline[cells[:, 0], cells[:, 1]] = True
            self.bead_map[cells[:, 0], cells[:, 1]] = False
            near = (cells[:, None, :] + SPACING_DISK[None, :, :]).reshape(-1, 2)
            self.start_blocked[near[:, 0], near[:, 1]] = True
            self.n_finished_beads += 1
        self.bead_active = False
        self.bead_last = None
        self.bead_cells = []

    def _deposit(self, ev, d):
        """Lay the deposit of action d; return the new covered, spilled and overfilled cells."""
        iy, ix, valid = ev["iy"][d][ev["valid"][d]], ev["ix"][d][ev["valid"][d]], ev["valid"][d]
        self.cov[iy, ix] += ev["added"][d][valid]
        c = self.cov[iy, ix]
        new_cov = self.goal[iy, ix] & ~self.covered[iy, ix] & (c >= C.COVERAGE_DONE)
        new_spill = self.nonpart[iy, ix] & ~self.spilled[iy, ix] & (c >= C.SPILL_LIMIT)
        new_over = self.goal[iy, ix] & ~self.overfilled[iy, ix] & (c > C.OVERLAP_LIMIT)
        cy, cx = iy[new_cov], ix[new_cov]
        self.covered[cy, cx] = True
        self.uncovered[cy, cx] = False
        self.uncovered_f[cy - PAD, cx - PAD] = 0.0
        self.covered_f[cy - PAD, cx - PAD] = 1.0
        self.spilled[iy[new_spill], ix[new_spill]] = True
        self.overfilled[iy[new_over], ix[new_over]] = True
        counts = int(new_cov.sum()), int(new_spill.sum()), int(new_over.sum())
        self.n_covered += counts[0]
        self.n_spilled += counts[1]
        self.n_overfilled += counts[2]
        return counts

    # ====================================================================
    # STEP
    # ====================================================================

    def step(self, action):
        action = int(action)
        ev = self._evaluate()
        self.steps += 1
        y, x = self.pos
        dy, dx = DIRECTION_TUPLES[action]
        blocked = not ev["moves"][action]
        printed = bool(ev["print"][action])
        g = self.total_goals
        cfg = self.cfg

        # === DEPOSITION AND BEAD STATE ===
        d_cov = d_spill = d_over = 0
        if printed:
            if ev["continues"][action]:
                self.bead_cells.append((y, x))
            else:
                self._end_bead()
                self.bead_active = True
                self.bead_cells = [(y, x)]
            self.bead_map[y + PAD, x + PAD] = True
            self.bead_last = (y, x)
            d_cov, d_spill, d_over = self._deposit(ev, action)
        else:
            if ev["ends_bead"] or ev["empty"][action]:
                self._end_bead()
            elif self.bead_active and self.bead_last is not None:
                ly, lx = self.bead_last              # The bead ends once the nozzle is too far from it.
                gy, gx = abs(y - ly), abs(x - lx)
                if max(gy, gx) > (3 if (gy == 0 or gx == 0) else 1):
                    self._end_bead()

        # === PRINT RUNS ===
        bead_start = printed and not self.prev_printed
        if bead_start:
            self.beads += 1
            if self.run_length:
                self.run_lengths.append(self.run_length)
            self.run_length = 0
        if printed:
            self.run_length += 1
        elif self.prev_printed and self.run_length:
            self.run_lengths.append(self.run_length)
            self.run_length = 0
        self.prev_printed = printed

        # === MOVE AND COUNTERS ===
        self.clock.advance(None if blocked else (dy, dx), K.PRINT if printed else K.TRAVEL)
        oscillating = False
        if not blocked:
            self.pos = (y + dy, x + dx)
            self.heading = action
            oscillating = self.pos in self.recent
            self.oscillation_moves += oscillating
            self.recent.append(self.pos)
        else:
            self.heading = None
            self.blocked_steps += 1
        if printed:
            self.print_steps += 1
        else:
            self.travel_steps += 1
        self.dry_steps = 0 if d_cov > 0 else self.dry_steps + 1
        self.episode_path.append((self.pos[0], self.pos[1], printed))

        # === REWARD TERMS ===
        terms = {
            "coverage": cfg["alpha_cover"] * d_cov / g,
            "spill": -cfg["alpha_spill"] * d_spill / g,
            "overfill": -cfg["alpha_overfill"] * d_over / g,
            "bead_start": -cfg["alpha_cover"] * cfg["bead_start_cells"] / g * bead_start,
            "travel": -cfg["alpha_travel"] * (not printed) / self.S_part,
            "time": -cfg["alpha_time"] / self.S_part,
            "boundary": -cfg["alpha_boundary"] * blocked / self.grid_scale,
            "oscillation": -cfg["alpha_oscillation"] * oscillating / self.grid_scale,
            # Completion pressure, paid as coverage is gained: worth more the closer the layer is to complete.
            "progress": cfg["alpha_fail"] * (math.sqrt(max(1.0 - (self.n_covered - d_cov) / g, 0.0))
                                             - math.sqrt(max(1.0 - self.n_covered / g, 0.0))) if d_cov else 0.0,
            "terminal": 0.0,
            "stranded": 0.0,
        }

        # === TERMINATION ===
        coverage = self.n_covered / g
        completed = False
        if self.n_covered == g:
            completed = True
        elif coverage >= self.limits["done_coverage"]:
            completed = self._clusters()[1] <= self.limits["done_max_void"]
        if completed:
            outcome = "completed"
        elif not self._printable()["flags"].any():
            outcome = "stranded"
        elif self.steps >= self.budget:
            outcome = "budget"
        elif self.dry_steps >= self.stall_limit:
            outcome = "stall"
        else:
            outcome = None
        terminated = outcome is not None
        quality = None
        if terminated:
            if self.run_length:
                self.run_lengths.append(self.run_length)
                self.run_length = 0
            self._end_bead()
            quality = self.layer_quality()
            if completed:
                terms["terminal"] = cfg["alpha_done"] + cfg["alpha_quality"] * quality["Q"]
            else:
                terms["terminal"] = -cfg["alpha_fail"]
                terms["stranded"] = -cfg["alpha_stranded"] * cfg["alpha_cover"] * self._printable()["stranded"] / g

        reward = float(sum(terms.values()))
        for k, v in terms.items():
            self.reward_totals[k] += v
        self.total_reward += reward
        info = {"reward_terms": terms, "coverage": coverage, "printed": printed,
                "bead_start": bead_start, "blocked": blocked, "oscillation": oscillating}
        if terminated:
            m = self.metrics()
            m.update(quality)
            info.update({"outcome": outcome, "episode_metrics": m, "reward_totals": dict(self.reward_totals),
                         "episode_path": list(self.episode_path)})
        return self._observation(), reward, terminated, False, info

    # ====================================================================
    # CLUSTERS AND NEAREST CELLS
    # ====================================================================

    def _clusters(self):
        """(count, largest) of the 8-connected clusters of uncovered part cells."""
        if self._cluster_key != self.n_covered:
            labels, n = ndimage.label(self.uncovered, structure=EIGHT)
            largest = int(np.bincount(labels.ravel())[1:].max()) if n else 0
            self._clusters_cache = (int(n), largest)
            self._cluster_key = self.n_covered
        return self._clusters_cache

    def _may_start(self, region):
        """Part cells where a new bead may start: away from finished beads and not overfilled."""
        return self.goal[region] & ~self.start_blocked[region] & (self.cov[region] < C.OVERLAP_LIMIT * 1.5)

    def _start_map(self):
        key = (self.n_finished_beads, self.print_steps)
        if self._start_key != key:
            self._start_cache = self._may_start(self._inner).astype(np.float32)
            self._start_key = key
        return self._start_cache

    def _remaining(self):
        if self._remaining_key != self.n_covered:
            self._remaining_cache = np.argwhere(self.uncovered[self._inner])
            self._remaining_key = self.n_covered
        return self._remaining_cache

    def _nearest(self, padded, cells):
        """(distance, dy, dx) to the nearest True cell of `padded` (grid cells `cells`), or None."""
        if not len(cells):
            return None
        y, x = self.pos
        r = C.LOCAL_RADIUS
        win = padded[y + PAD - r:y + PAD + r + 1, x + PAD - r:x + PAD + r + 1]
        if win.any():
            dist = np.where(win, LOCAL_DIST, np.inf)
            i = int(np.argmin(dist))
            if dist.flat[i] <= r:
                wy, wx = divmod(i, 2 * r + 1)
                return float(dist.flat[i]), wy - r, wx - r
        d2 = (cells[:, 0] - y) ** 2 + (cells[:, 1] - x) ** 2
        i = int(np.argmin(d2))
        return float(math.sqrt(d2[i])), int(cells[i, 0] - y), int(cells[i, 1] - x)

    def _nearest_printable(self):
        p = self._printable()
        return self._nearest(p["padded"], p["cells"])

    # ====================================================================
    # PRINTABLE VOIDS
    # ====================================================================

    def _bead_open(self):
        """The open bead can continue from the nozzle (the nozzle is next to its last deposit)."""
        if not self.bead_active or self.bead_last is None:
            return False
        ady, adx = abs(self.pos[0] - self.bead_last[0]), abs(self.pos[1] - self.bead_last[1])
        return ady + adx > 0 and max(ady, adx) <= 1

    def _void_clusters(self):
        """(labels, cells per label, centroid per label, label count) of the uncovered part cells,
        cells at most 2 x VOID_LINK covered cells apart sharing a cluster."""
        if self._void_key != self.n_covered:
            unc = self.uncovered[self._inner].astype(np.uint8)
            linked = cv2.dilate(unc, LINK_KERNEL) & self.goal_u8
            n, labels = cv2.connectedComponents(linked, connectivity=8)
            labels[unc == 0] = 0
            flat = labels.ravel()
            sizes = np.bincount(flat, minlength=n)
            sizes[0] = 0
            div = np.maximum(sizes, 1)
            cents = np.stack([np.bincount(flat, weights=self._cell_y, minlength=n) / div,
                              np.bincount(flat, weights=self._cell_x, minlength=n) / div], axis=1)
            self._void_cache = (labels, sizes, cents, int(n))
            self._void_key = self.n_covered
        return self._void_cache

    def _rule_flags(self, labels, sizes, n):
        """Printable flag per cluster: at least VOID_MIN_CELLS cells and a bead start within VOID_REACH."""
        ok = sizes >= C.VOID_MIN_CELLS
        if ok.any():
            near = cv2.dilate((self._start_map() > 0).astype(np.uint8), REACH_KERNEL).astype(bool)
            ok &= np.bincount(labels[near], minlength=n) > 0
        ok[0] = False
        return ok

    def _rule_active(self):
        return self.n_covered >= C.VOID_RULE_COVERAGE * self.total_goals

    def _printable(self):
        """Printable void clusters ('flags', 'mask', 'padded', 'cells', 'cells_n', 'largest', 'count')
        and 'stranded', the cells printable at the start that are in an unprintable cluster now.
        Below VOID_RULE_COVERAGE every cluster is printable."""
        labels, sizes, _, n = self._void_clusters()
        active = self._rule_active()
        base_key = (self.n_covered, self.n_finished_beads)
        if self._base_key != base_key:
            self._base_flags = self._rule_flags(labels, sizes, n) if active else sizes > 0
            self._base_key = base_key
        sweep = ()
        if active and self._bead_open():
            y, x = self.pos
            r = C.VOID_REACH
            win = labels[max(y - r, 0):y + r + 1, max(x - r, 0):x + r + 1]
            sweep = tuple(int(v) for v in np.unique(win[win > 0]) if not self._base_flags[v])
        key = (base_key, sweep)
        if self._printable_key != key:
            flags = self._base_flags.copy()
            flags[list(sweep)] = True
            mask = flags[labels]
            self._printable_pad[self._inner] = mask
            unc = self.uncovered[self._inner]
            self._printable_cache = {
                "flags": flags, "mask": mask, "padded": self._printable_pad, "cells": np.argwhere(mask),
                "cells_n": int(sizes[flags].sum()), "largest": int(sizes[flags].max()) if flags.any() else 0,
                "count": int(flags.sum()),
                "stranded": int((unc & ~mask & self.printable0).sum()) if active else 0,
            }
            self._printable_key = key
        return self._printable_cache

    def _cleanup_tour(self, near):
        """Steps of a greedy tour from the nozzle over the printable clusters (nearest centroid next)."""
        if near is None:
            return 0.0
        _, ndy, ndx = near
        labels, _, cents, _ = self._void_clusters()
        first = int(labels[self.pos[0] + ndy, self.pos[1] + ndx])
        key = (self._printable_key, first)
        if self._tour_key != key:
            ids = np.flatnonzero(self._printable()["flags"])
            pts = cents[ids]
            left = ids != first
            cur, length = pts[~left][0], 0.0
            while left.any():
                d = np.abs(pts[left] - cur).max(axis=1)
                j = int(np.argmin(d))
                length += float(d[j])
                k = np.flatnonzero(left)[j]
                cur = pts[k]
                left[k] = False
            self._tour_cache = length
            self._tour_key = key
        return max(abs(ndy), abs(ndx)) + self._tour_cache

    def _rays(self):
        """(8, 3) per direction along a 3-cell band to the grid edge: printable void cells, distance
        to the first, and the straight run of printable void from there, each as x / (x + RAY_SCALE)."""
        mask = self._printable()["mask"]
        n = self.N
        y, x = self.pos
        cy, cx = y + self.rays[..., 0], x + self.rays[..., 1]
        inside = (cy >= 0) & (cy < n) & (cx >= 0) & (cx < n)
        hit = mask[np.clip(cy, 0, n - 1), np.clip(cx, 0, n - 1)] & inside
        band = hit.any(axis=2) & inside[:, :, 1]
        steps = np.arange(n)
        found = band.any(axis=1)
        first = np.where(found, band.argmax(axis=1), n)
        filled = band | (steps[None, :] < first[:, None])
        end = np.where((~filled).any(axis=1), (~filled).argmax(axis=1), n)
        count = band.sum(axis=1).astype(np.float64)
        dist = (first + 1).astype(np.float64)
        run = np.where(found, end - first, 0).astype(np.float64)
        s = C.RAY_SCALE
        return np.stack([count / (count + s), np.where(found, dist / (dist + s), 1.0), run / (run + s)], axis=1)

    # ====================================================================
    # LAYER QUALITY AND METRICS
    # ====================================================================

    def layer_quality(self):
        """Q in [0, 1]: weighted mean of the void, bead and material scores."""
        cfg = self.cfg
        _, largest = self._clusters()
        q_void = 1.0 - min(1.0, largest / self.void_tolerance)
        q_bead = 1.0 / (1.0 + max(0, self.beads - self.islands) / cfg["bead_scale"])
        affected = self.n_covered + self.n_spilled
        q_mat = (self.n_covered - self.n_overfilled) / affected if affected else 0.0
        wv, wb, wm = cfg["quality_weights"]
        total = wv + wb + wm
        return {"Q": (wv * q_void + wb * q_bead + wm * q_mat) / total,
                "q_void": q_void, "q_bead": q_bead, "q_material": q_mat, "largest_void": largest}

    def metrics(self):
        runs = self.run_lengths + ([self.run_length] if self.run_length else [])
        clusters, largest = self._clusters()
        printable = self._printable()
        return {
            "coverage": self.n_covered / self.total_goals,
            "steps": self.steps,
            "print_steps": self.print_steps,
            "travel_steps": self.travel_steps,
            "blocked_steps": self.blocked_steps,
            "oscillation_moves": self.oscillation_moves,
            "travel_ratio": self.travel_steps / max(self.steps, 1),
            "travel_per_ideal": self.travel_steps / self.S_part,
            "beads": self.beads,
            "mean_bead_steps": float(np.mean(runs)) if runs else 0.0,
            "spilled_cells": self.n_spilled,
            "overfilled_cells": self.n_overfilled,
            "void_clusters": clusters,
            "largest_void": largest,
            "printable_clusters": printable["count"],
            "unprintable_cells": self.total_goals - self.n_covered - printable["cells_n"],
            "stranded_cells": printable["stranded"],
            "print_time_s": self.clock.time,
            "S_part": self.S_part,
            "total_goals": self.total_goals,
            "islands": self.islands,
        }

    # ====================================================================
    # OBSERVATION
    # ====================================================================

    def _observation(self):
        ev = self._evaluate()

        # === LOCAL MAP ===
        y, x = self.pos
        py, px = y + PAD, x + PAD
        r = C.LOCAL_RADIUS
        win = (slice(py - r, py + r + 1), slice(px - r, px + r + 1))
        local = np.stack([
            self.uncovered[win],
            np.minimum(self.cov[win] / C.OVERLAP_LIMIT, 1.0),
            self.nonpart[win],
            self.outside[win],
            self.centerline[win],
            self._may_start(win),
            self.bead_map[win],
        ]).astype(np.float32)

        # === GLOBAL MAP ===
        printable = self._printable()
        gs = C.GLOBAL_SIZE
        nozzle = np.zeros((gs, gs), dtype=np.float32)
        nozzle[min(y * gs // self.N, gs - 1), min(x * gs // self.N, gs - 1)] = 1.0
        glob = np.stack([
            cv2.resize(self.uncovered_f, (gs, gs), interpolation=cv2.INTER_AREA),
            cv2.resize(self.covered_f, (gs, gs), interpolation=cv2.INTER_AREA),
            nozzle,
            cv2.resize(self._start_map(), (gs, gs), interpolation=cv2.INTER_AREA),
            cv2.resize(printable["mask"].astype(np.float32), (gs, gs), interpolation=cv2.INTER_AREA) > 0,
        ]).astype(np.float32)

        # === ACTION PREVIEW (column 5 unused) ===
        preview = np.zeros((8, C.PREVIEW_FEATURES), dtype=np.float32)
        printing = ev["print"]
        preview[:, 0] = printing
        preview[:, 1] = printing & (not self.prev_printed)
        preview[:, 2] = ev["new_covered"] / K_MAX
        preview[:, 3] = ev["new_spill"] / K_MAX
        preview[:, 4] = ev["new_over"] / K_MAX
        preview[:, 6] = ~ev["moves"]
        preview[:, 7] = [ev["moves"][d] and (y + dy, x + dx) in self.recent
                         for d, (dy, dx) in enumerate(DIRECTION_TUPLES)]
        preview[:, 8:11] = self._rays()

        # === STATE VECTOR (15 and 28 unused) ===
        state = np.zeros(C.STATE_FEATURES, dtype=np.float32)
        g = self.total_goals
        state[0] = self.n_covered / g
        state[1] = min(self.steps / self.budget, 1.0)
        if self.heading is not None:
            state[2 + self.heading] = 1.0
        state[10] = self.prev_printed
        state[11] = min(self.clock.length / 32.0, 1.0)
        state[12] = self.run_length / (self.run_length + 16.0)
        state[13] = min(self.dry_steps / self.stall_limit, 1.0)
        state[14] = self.beads / (self.beads + self.cfg["bead_scale"])
        state[16] = self.travel_steps / (self.travel_steps + self.S_part)
        near = self._nearest_printable()
        if near is not None:
            dist, ndy, ndx = near
            state[17] = min(dist / self.N, 1.0)
            angle = math.atan2(ndy, ndx)
            state[18], state[19] = math.sin(angle), math.cos(angle)
        n_clusters, largest = self._clusters()
        remaining = g - self.n_covered
        state[20] = n_clusters / (n_clusters + 5.0)
        state[21] = largest / remaining if remaining else 0.0
        state[22] = y / (self.N - 1)
        state[23] = x / (self.N - 1)
        state[24] = min(max(math.log2(self.N / 100.0) / 3.0, 0.0), 1.0)
        state[25] = self.bead_active
        lim = self.limits
        state[26] = lim["done_coverage"]
        state[27] = min(lim["done_max_void"] / self.void_tolerance, 1.0)
        # Travel and time weights in force relative to their defaults (0.5 at the default).
        for i, k in enumerate(("alpha_travel", "alpha_time")):
            state[29 + i] = self.cfg[k] / (self.cfg[k] + C.REWARD[k])
        # Gap to completion: coverage short of the bar, the largest printable void against the
        # void limit, the void criterion, print steps the printable voids need against the steps
        # left, the clean-up tour in units of S_part, cells stranded so far, printable clusters.
        state[31] = min(10.0 * max(lim["done_coverage"] - self.n_covered / g, 0.0), 1.0)
        state[32] = printable["largest"] / max(printable["largest"] + lim["done_max_void"], 1)
        state[33] = largest <= lim["done_max_void"]
        need = printable["cells_n"] * self.S_part / g
        state[34] = min(need / max(self.budget - self.steps, 1), 1.0)
        state[35] = min(self._cleanup_tour(near) / self.S_part, 1.0)
        state[36] = min(10.0 * printable["stranded"] / g, 1.0)
        state[37] = printable["count"] / (printable["count"] + 5.0)
        return {"local_map": local, "global_map": glob, "action_preview": preview, "state": state}
