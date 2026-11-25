"""Step clock and reference raster of the environment.

A segment is a run of steps with the same direction and mode (print or travel), executed
rest to rest with a trapezoidal speed profile. Each step is charged the increase of its
segment's time, so a turn or a mode switch starts a new segment (acceleration again, plus a
retraction or prime).

S_part, the print steps of a serpentine raster of the part, normalises the travel and time
terms of the reward. Of the two scan axes and four ways to begin, the raster with the lowest
cost (mass-weighted axis motion plus TIME_COST x time) is used.
"""

import math

import numpy as np

import settings as C

TRAVEL, PRINT = 0, 1
_SPEED = {TRAVEL: C.TRAVEL_SPEED, PRINT: C.PRINT_SPEED}
_ACCEL = {TRAVEL: C.TRAVEL_ACCEL, PRINT: C.PRINT_ACCEL}


def saturation(mode):
    """Distance in mm an axis needs to reach cruise speed."""
    return _SPEED[mode] ** 2 / _ACCEL[mode]


def duration(length_mm, mode):
    """Rest-to-rest time in s of a segment."""
    if length_mm <= 0.0:
        return 0.0
    v, a = _SPEED[mode], _ACCEL[mode]
    if length_mm >= v * v / a:
        return length_mm / v + v / a
    return 2.0 * math.sqrt(length_mm / a)


def switch_time(prev_mode, mode):
    """Retraction when a bead ends, prime when one starts."""
    if prev_mode == PRINT and mode == TRAVEL:
        return C.RETRACT_TIME
    if prev_mode != PRINT and mode == PRINT:
        return C.PRIME_TIME
    return 0.0


def axis_cost(dx_mm, dy_mm, mode):
    """Mass-weighted axis motion: acceleration distance plus COAST_COST x the rest."""
    limit = saturation(mode)
    cost = 0.0
    for d, mass in ((abs(dx_mm), C.MASS_X), (abs(dy_mm), C.MASS_Y)):
        if d > 0.0:
            cost += mass * (min(d, limit) + C.COAST_COST * max(d - limit, 0.0))
    return cost


def segment(n_cells, dy, dx, mode):
    """(time s, axis cost) of a segment of n_cells steps of (dy, dx)."""
    if n_cells <= 0:
        return 0.0, 0.0
    step_mm = math.hypot(dy, dx) * C.CELL_MM
    return (duration(n_cells * step_mm, mode),
            axis_cost(n_cells * dx * C.CELL_MM, n_cells * dy * C.CELL_MM, mode))


class SegmentClock:
    """Print time of the episode, charged step by step."""

    def __init__(self):
        self.reset()

    def reset(self):
        self.mode = TRAVEL
        self.direction = None    # (dy, dx) of the open segment; None after a stop.
        self.length = 0          # Steps in the open segment.
        self.time = 0.0

    def step_time(self, direction, mode):
        """Time the step adds. A blocked move (direction None) takes the time of a one-cell travel."""
        if direction is None:
            return switch_time(self.mode, TRAVEL) + duration(C.CELL_MM, TRAVEL)
        dy, dx = direction
        if mode == self.mode and direction == self.direction and self.length > 0:
            return segment(self.length + 1, dy, dx, mode)[0] - segment(self.length, dy, dx, mode)[0]
        return segment(1, dy, dx, mode)[0] + switch_time(self.mode, mode)

    def advance(self, direction, mode):
        dt = self.step_time(direction, mode)
        if direction is None:
            self.mode, self.direction, self.length = TRAVEL, None, 0
        elif mode == self.mode and direction == self.direction and self.length > 0:
            self.length += 1
        else:
            self.mode, self.direction, self.length = mode, direction, 1
        self.time += dt
        return dt


def _travel(dy, dx):
    """(time, axis cost) of the shortest 8-direction travel by (dy, dx) cells: diagonal, then straight."""
    ady, adx = abs(dy), abs(dx)
    sy, sx = int(np.sign(dy)), int(np.sign(dx))
    diagonal, straight = min(ady, adx), abs(ady - adx)
    t1, c1 = segment(diagonal, sy, sx, TRAVEL)
    t2, c2 = segment(straight, sy if ady > adx else 0, 0 if ady > adx else sx, TRAVEL)
    return t1 + t2, c1 + c2


def _row_runs(arr, pitch):
    """Runs of part cells along rows one pitch apart: [[(row, first col, last col), ...] per row]."""
    filled = np.flatnonzero(arr.any(axis=1))
    out = []
    for r in range(filled[0] + pitch // 2, filled[-1] + 1, pitch):
        padded = np.concatenate(([False], arr[r], [False])).astype(np.int8)
        edges = np.flatnonzero(np.diff(padded))
        runs = [(int(r), int(a), int(b) - 1) for a, b in zip(edges[0::2], edges[1::2])]
        if runs:
            out.append(runs)
    return out


def reference_print_steps(goal, start):
    """S_part: print steps of the reference raster of a part mask, the nozzle starting at `start`.

    Rows lie one bead pitch apart; each run of part cells along a row is one bead (prime, print,
    retract), and the nozzle travels from the start to the first run and between runs."""
    pitch = int(round(C.BEAD_PITCH))
    best = None
    for transpose in (False, True):
        arr = goal.T if transpose else goal
        if not arr.any():
            continue
        rows = _row_runs(arr, pitch)
        to_grid = (lambda r, c: (c, r)) if transpose else (lambda r, c: (r, c))
        step = (1, 0) if transpose else (0, 1)
        steps = sum(b - a + 1 for runs in rows for _, a, b in runs)
        printing = 0.0
        for runs in rows:
            for _, a, b in runs:
                t, c = segment(b - a + 1, *step, PRINT)
                printing += c + C.TIME_COST * (t + C.PRIME_TIME + C.RETRACT_TIME)
        for order in (rows, rows[::-1]):
            for rightward in (True, False):
                cost, pos = printing, start
                for k, runs in enumerate(order):
                    forward = rightward == (k % 2 == 0)
                    for r, a, b in (runs if forward else runs[::-1]):
                        first, last = (a, b) if forward else (b, a)
                        y, x = to_grid(r, first)
                        t, c = _travel(y - pos[0], x - pos[1])
                        cost += c + C.TIME_COST * t
                        pos = to_grid(r, last)
                if best is None or cost < best[0]:
                    best = (cost, steps)
    if best is None:
        return max(max(int(goal.sum()), 1) / C.BEAD_PITCH, 1.0)
    return float(best[1])
