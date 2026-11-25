"""Reading and timing one G-code layer.

The parser follows absolute or relative extrusion (M82/M83), G92, G90/G91, firmware
retraction (G10/G11) and G2/G3 arcs (as chords). A bead is a run of extruding moves ended
by a travel or a retraction.
"""

import math

import numpy as np

EXTRUDE_MM = 1e-5                # Filament (mm) above which a move extrudes, below minus which it retracts.
ARC_SEGMENT_MM = 0.1


def read_gcode_file(path):
    for encoding in ("utf-8", "latin-1"):
        try:
            with open(path, "r", encoding=encoding) as f:
                return [line.strip() for line in f]
        except UnicodeDecodeError:
            continue
    raise ValueError(f"Unable to read: {path}")


def main_path(lines):
    """The ';--- Main Path ---' section of an RL file (start-up and shutdown removed).
    A file without the marker, such as a baseline layer, is returned whole."""
    start = next((i + 1 for i, l in enumerate(lines) if l.strip().startswith(";--- Main Path")), 0)
    end = next((i for i in range(start, len(lines)) if lines[i].strip().startswith(";--- Shutdown")), len(lines))
    return lines[start:end]


def arc_points(start, end, clockwise, offset=None, radius=None, max_segment=ARC_SEGMENT_MM):
    """Chord points of a G2 (clockwise) or G3 arc, the last one at `end`."""
    (x0, y0), (x1, y1) = start, end
    if offset is not None:
        cx, cy = x0 + offset[0], y0 + offset[1]
    else:
        dx, dy = x1 - x0, y1 - y0
        d = math.hypot(dx, dy)
        if not radius or d == 0:
            return [end]
        e = -1.0 if clockwise ^ (radius < 0) else 1.0
        h = math.sqrt(max(radius ** 2 - (d / 2) ** 2, 0.0))
        cx, cy = (x0 + x1) / 2 - e * h * dy / d, (y0 + y1) / 2 + e * h * dx / d
    r = math.hypot(x0 - cx, y0 - cy)
    a0, a1 = math.atan2(y0 - cy, x0 - cx), math.atan2(y1 - cy, x1 - cx)
    sweep = ((a0 - a1) if clockwise else (a1 - a0)) % (2 * math.pi)
    if sweep < 1e-9 and math.hypot(x1 - x0, y1 - y0) < 1e-9:
        sweep = 2 * math.pi
    n = max(1, math.ceil(r * sweep / max_segment))
    step = -sweep / n if clockwise else sweep / n
    return [(cx + r * math.cos(a0 + step * k), cy + r * math.sin(a0 + step * k)) for k in range(1, n)] + [(x1, y1)]


def _values(words):
    values = {}
    for w in words:
        if len(w) > 1 and w[0] in "XYZEFIJR":
            try:
                values[w[0]] = float(w[1:])
            except ValueError:
                pass
    return values


def _command(g, start, pos, e_inc, feed):
    first = start["X"] is None or start["Y"] is None
    dist = 0.0 if first else math.hypot(pos["X"] - start["X"], pos["Y"] - start["Y"])
    return {"G": g, "X": pos["X"], "Y": pos["Y"], "Z": pos["Z"],
            "start": None if first else (start["X"], start["Y"]), "dist": dist,
            "E_increment": e_inc, "F": feed, "is_retraction": e_inc < -EXTRUDE_MM}


def parse(lines):
    """One dict per move: X, Y, Z, start (previous X, Y), dist (XY length), E_increment, F, is_retraction."""
    commands = []
    pos = {"X": None, "Y": None, "Z": 0.0}
    e_pos, absolute_e, absolute_xyz, feed = 0.0, True, True, 1800.0
    for raw in lines:
        code = raw.split(";", 1)[0].strip().upper()
        if not code:
            continue
        words = code.split()
        cmd = words[0]
        if cmd == "M82":
            absolute_e = True
        elif cmd == "M83":
            absolute_e = False
        elif cmd == "G90":
            absolute_xyz = True
        elif cmd == "G91":
            absolute_xyz = False
        elif cmd == "G92":
            values = _values(words[1:])
            if "E" in values:
                e_pos = values["E"]
            for axis in ("X", "Y", "Z"):
                if axis in values:
                    pos[axis] = values[axis]
        elif cmd in ("G10", "G11") and pos["X"] is not None and pos["Y"] is not None:
            commands.append(_command("G1", pos, pos, 0.0, feed))
            commands[-1]["is_retraction"] = cmd == "G10"
        elif cmd in ("G0", "G1", "G00", "G01"):
            values = _values(words[1:])
            if "F" in values:
                feed = values["F"]
            start = dict(pos)
            for axis in ("X", "Y", "Z"):
                if axis in values:
                    pos[axis] = values[axis] if absolute_xyz or pos[axis] is None else pos[axis] + values[axis]
            e_inc = 0.0
            if "E" in values:
                e_inc = values["E"] - e_pos if absolute_e else values["E"]
                e_pos = values["E"] if absolute_e else e_pos + values["E"]
            if not ({"X", "Y", "Z"} & set(values)) and "E" not in values:
                continue
            if pos["X"] is None or pos["Y"] is None:
                continue
            commands.append(_command("G0" if cmd in ("G0", "G00") else "G1", start, pos, e_inc, feed))
        elif cmd in ("G2", "G3", "G02", "G03"):
            values = _values(words[1:])
            if "F" in values:
                feed = values["F"]
            if pos["X"] is None or pos["Y"] is None:
                continue
            start = dict(pos)
            for axis in ("X", "Y", "Z"):
                if axis in values:
                    pos[axis] = values[axis] if absolute_xyz else pos[axis] + values[axis]
            e_inc = 0.0
            if "E" in values:
                e_inc = values["E"] - e_pos if absolute_e else values["E"]
                e_pos = values["E"] if absolute_e else e_pos + values["E"]
            offset = (values.get("I", 0.0), values.get("J", 0.0)) if ("I" in values or "J" in values) else None
            points = arc_points((start["X"], start["Y"]), (pos["X"], pos["Y"]), cmd in ("G2", "G02"),
                                offset, values.get("R"))
            z0, prev = start["Z"], dict(start)
            for k, (x, y) in enumerate(points, 1):
                here = {"X": x, "Y": y, "Z": z0 + (pos["Z"] - z0) * k / len(points)}
                commands.append(_command("G1", prev, here, e_inc / len(points), feed))
                prev = here
    return commands


def extruding(cmd):
    return cmd["E_increment"] > EXTRUDE_MM and cmd["dist"] > 0


def travelling(cmd):
    return cmd["dist"] > 0 and not cmd["E_increment"] > EXTRUDE_MM


def bead_lengths(commands):
    beads, current = [], None
    for cmd in commands:
        if extruding(cmd):
            current = (current or 0.0) + cmd["dist"]
        elif current is not None and (travelling(cmd) or cmd["is_retraction"]):
            beads.append(current)
            current = None
    if current is not None:
        beads.append(current)
    return beads


def _segment_time(distance, v_now, v_target, accel):
    """(time, exit speed in mm/min) of one move with a trapezoidal speed profile."""
    v0, v1 = v_now / 60.0, v_target / 60.0
    dv = abs(v1 - v0)
    if dv < 0.001:
        return (distance / v1 if v1 > 0 else 0.0), v_target
    t_acc = dv / accel
    d_acc = 0.5 * dv * t_acc
    if d_acc >= distance:
        return float(np.sqrt(2 * distance / accel)), (v0 + v1) * 0.5 * 60.0
    return t_acc + (distance - d_acc) / v1, v_target


def analyze(commands, machine):
    """Print time (trapezoidal profile, no slowdown at corners), path lengths, retractions and beads."""
    accel = machine["max_acceleration"]
    v = total = 0.0
    printed = travel = 0.0
    retractions, retracting = 0, False
    for cmd in commands:
        extrudes = cmd["E_increment"] > EXTRUDE_MM
        if cmd["dist"] > 0:
            target = machine["force_print_feedrate"] if extrudes else machine["force_travel_feedrate"]
            t, v = _segment_time(cmd["dist"], v, target, accel)
            total += t
            if extrudes:
                printed += cmd["dist"]
            else:
                travel += cmd["dist"]
        if cmd["is_retraction"] and not retracting:
            retractions += 1
        retracting = cmd["is_retraction"]
    beads = bead_lengths(commands)
    return {"print_time_s": float(total), "extruded_mm": float(printed), "travel_mm": float(travel),
            "retractions": int(retractions), "extrusion_starts": len(beads),
            "mean_bead_mm": float(np.mean(beads)) if beads else 0.0,
            "lcf": float(max(beads) / printed) if beads and printed > 0 else 0.0}
