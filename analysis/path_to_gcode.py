"""G-code of an RL rollout (results/raw/.../json/image_<n>_path.json) for a Prusa MK4.

Processing of the cell path, a list of (row, col, deposit):
  1. a run of travel cells becomes one straight travel
  2. consecutive moves of one kind are joined while the joined line stays within 0.5 cell of
     every dropped point (Ramer-Douglas-Peucker on each run); bead ends are kept
  3. moves before the first bead are dropped; the nozzle comes from the purge line
Retraction of 0.7 mm at 35 mm/s with a 0.2 mm Z hop, only before travels of 1.5 mm or more.
A print move extrudes the cross-section of a 0.45 mm line at 0.2 mm layer height,
(0.45 - h (1 - pi/4)) h = 0.0814 mm^2. Y points up the bed: Y = (rows - 1 - row) * cell.

Edit the settings below and run:

    python analysis/path_to_gcode.py
"""

import json
import os

import numpy as np

import config as C

# === SETTINGS ===
PATH_JSON = os.path.join(C.RAW, "500x500", "1_simple", "json", "image_1_path.json")
OUTPUT = os.path.join(C.REPRODUCED, "gcode_rl", "image_1.gcode")

RETRACT_MM = 0.7
RETRACT_FEED = 2100
Z_HOP_MM = 0.2
MIN_RETRACT_TRAVEL_MM = 1.5
SMOOTHING_CELLS = 0.5
PRINT_FEED = 3600
TRAVEL_FEED = 9000
NOZZLE_TEMP = 200.0
BED_TEMP = 60.0
EXTRUSION_MULTIPLIER = (C.LINE_MM - C.ROUNDING_MM) / C.NOZZLE_MM      # 0.4 x 0.2 rectangle -> 0.45 mm line.
BED_X = 250.0


def simplify_travel(path):
    out, i = [], 0
    while i < len(path):
        row, col, dep = path[i]
        if dep:
            out.append((row, col, dep))
            i += 1
            continue
        j = i
        while j < len(path) and not path[j][2]:
            j += 1
        out.append((row, col, False))
        if j - i > 1:
            out.append((path[j - 1][0], path[j - 1][1], False))
        i = j
    return out


def _rdp_keep(points, tolerance):
    """Indices Ramer-Douglas-Peucker keeps. Distance is to the segment, and a run that
    doubles back along it is split at the turn."""
    keep = np.zeros(len(points), dtype=bool)
    keep[[0, -1]] = True
    stack = [(0, len(points) - 1)]
    while stack:
        a, b = stack.pop()
        if b - a < 2:
            continue
        p, d = points[a], points[b] - points[a]
        mid = points[a + 1:b]
        length2 = float(d @ d)
        t = (mid - p) @ d / length2 if length2 > 0 else np.zeros(len(mid))
        dist = np.linalg.norm(mid - (p + np.clip(t, 0.0, 1.0)[:, None] * d), axis=1)
        k = int(np.argmax(dist))
        if dist[k] > tolerance + 1e-9 or length2 == 0:
            m = a + 1 + k
        else:
            back = np.diff(np.concatenate(([0.0], t, [1.0])))
            if back.min() >= -1e-9:
                continue
            m = a + max(int(np.argmin(back)), 1)
        keep[m] = True
        stack += [(a, m), (m, b)]
    return np.flatnonzero(keep)


def merge_moves(path, tolerance):
    path = list(path)
    if len(path) < 3:
        return path
    merged, i = [path[0]], 1
    while i < len(path):
        dep, j = path[i][2], i
        while j + 1 < len(path) and path[j + 1][2] == dep:
            j += 1
        pts = np.array([p[:2] for p in path[i - 1:j + 1]], dtype=float)
        merged.extend(path[i - 1 + k] for k in _rdp_keep(pts, tolerance)[1:])
        i = j + 1
    return merged


def start_gcode(print_area, homing_temp=170.0):
    """MK4 start-up as in PrusaSlicer: heat, home, mesh bed levelling over the print area, purge line."""
    x_min, y_min, x_max, y_max = print_area
    area_x = min(BED_X, x_min + 32) - 32
    area_y = max(0.0, y_min) - 4
    area_w = min(BED_X, max(x_min + 32, x_max)) - area_x
    area_h = y_max - area_y
    lines = [
        "G90                      ; absolute coordinates",
        "M82                      ; absolute extrusion",
        f"M555 X{area_x:.3f} Y{area_y:.3f} W{area_w:.3f} H{area_h:.3f} ; print area for bed levelling",
        f"M140 S{BED_TEMP}         ; set bed temp",
        f"M104 S{homing_temp}        ; nozzle to bed-levelling temp (does not ooze)",
        f"M109 R{homing_temp}        ; wait for bed-levelling temp",
        "M84 E                    ; turn off E motor",
        "G28                      ; home all without mesh bed level",
        "G1 X42 Y-4 Z5 F4800",
        "M302 S160                ; lower cold extrusion limit to 160C",
        "G92 E0                   ; reset extruder",
        "G1 E-2 F2400             ; retraction",
        "M84 E                    ; turn off E motor",
        "G29 P9 X10 Y-4 W32 H4    ; clean the nozzle",
    ]
    if BED_TEMP <= 60:
        lines.append("M106 S100                ; fan on while the bed heats")
    lines += [
        "G0 Z40 F10000",
        f"M190 S{BED_TEMP}         ; wait for bed temp",
        "M107                     ; fan off",
        ";--- Bed Levelling ---",
        "M84 E                    ; turn off E motor",
        "G29 P1                   ; invalidate mbl & probe print area",
        "G29 P1 X0 Y0 W50 H20 C   ; probe near purge place",
        "G29 P3.2                 ; interpolate mbl probes",
        "G29 P3.13                ; extrapolate mbl outside probe area",
        "G29 A                    ; activate mbl",
        ";--- Purge Line ---",
        f"M104 S{NOZZLE_TEMP}      ; set extruder temp",
        "G0 X0 Y-4 Z15 F4800      ; move away and ready for the purge",
        f"M109 S{NOZZLE_TEMP}      ; wait for extruder temp",
        "M569 S0 E                ; set spreadcycle mode for extruder",
        "G92 E0                   ; reset extruder",
        "G1 E2 F2400              ; de-retract (undoes the retraction before probing)",
        "G1 X15 Z0.2 E9 F500      ; purge",
        "G1 X25 E13 F500          ; purge",
        "G1 X35 E17 F650          ; purge",
        "G1 X45 E21 F800          ; purge",
        "G1 X48 Z0.05 F8000       ; wipe, move close to the bed",
        "G1 X51 Z0.2 F8000        ; wipe, move quickly away from the bed",
        "G92 E0                   ; reset extruder",
        "M221 S100                ; set flow to 100%",
    ]
    return lines


def to_gcode(path_cells, cell_mm, grid_rows):
    first = next((k for k, p in enumerate(path_cells) if p[2]), None)
    if first is None:
        raise ValueError("path has no print moves")
    path = list(path_cells[max(first - 1, 0):])       # A bead starts at the point before its first print point.
    top = (grid_rows - 1) if grid_rows else (max(p[0] for p in path) or 1)
    pts = [(c * cell_mm, (top - r) * cell_mm) for r, c, _ in path]
    printed = [pts[k] for k in range(len(path)) if path[k][2] or (k + 1 < len(path) and path[k + 1][2])]
    area = (min(x for x, _ in printed), min(y for _, y in printed),
            max(x for x, _ in printed), max(y for _, y in printed))

    h = C.LAYER_HEIGHT_MM
    lines = [";FLAVOR:Marlin", f";Generated from path with {len(path_cells)} points", f";Layer height: {h} mm",
             f";Nozzle diameter: {C.NOZZLE_MM} mm", f";Retraction distance: {RETRACT_MM} mm",
             f";Retraction speed: {RETRACT_FEED} mm/min", ";MATERIAL:PLA"]
    lines += start_gcode(area)
    filament_area = (C.FILAMENT_MM / 2) ** 2 * np.pi
    travel_z = h + Z_HOP_MM
    e = -RETRACT_MM
    lines += [f"G1 E{e:.5f} F{RETRACT_FEED} ; retract", f"G1 Z{travel_z:.3f} F{TRAVEL_FEED} ; lift"]
    retracted = True
    lines.append(";--- Main Path ---")
    for i, (r, c, dep) in enumerate(path):
        x, y = pts[i]
        if i == 0:
            lines.append(f"G0 X{x:.3f} Y{y:.3f} F{TRAVEL_FEED} ; to first bead")
            continue
        px, py = pts[i - 1]
        dist = np.hypot(x - px, y - py)
        if not dep and path[i - 1][2] and not retracted:
            j = i
            while j < len(path) and not path[j][2]:
                j += 1
            travel = sum(np.hypot(pts[k][0] - pts[k - 1][0], pts[k][1] - pts[k - 1][1]) for k in range(i, j))
            if j == len(path) or travel >= MIN_RETRACT_TRAVEL_MM:
                e -= RETRACT_MM
                lines.append(f"G1 E{e:.5f} F{RETRACT_FEED} ; retract")
                retracted = True
                lines.append(f"G1 Z{travel_z:.3f} F{TRAVEL_FEED} ; z-hop")
        elif dep and retracted:
            lines.append(f"G1 Z{h:.3f} F{TRAVEL_FEED} ; lower z")
            e += RETRACT_MM
            lines.append(f"G1 E{e:.5f} F{RETRACT_FEED} ; unretract")
            retracted = False
        if dep:
            e += C.NOZZLE_MM * h * dist / filament_area * EXTRUSION_MULTIPLIER
            lines.append(f"G1 X{x:.3f} Y{y:.3f} E{e:.5f} F{PRINT_FEED}")
        else:
            lines.append(f"G0 X{x:.3f} Y{y:.3f} F{TRAVEL_FEED}")
    lines.append(";--- Shutdown ---")
    if not retracted:
        e -= RETRACT_MM
        lines.append(f"G1 E{e:.5f} F{RETRACT_FEED} ; final retract")
    lines += ["G92 E0                   ; reset extruder", "G1 Z5.0 F3000            ; lift nozzle",
              "M104 S0                  ; turn off hotend", "M140 S0                  ; turn off bed",
              "M107                     ; turn off fan", "G28 X Y                  ; home X and Y",
              "M84                      ; disable steppers", ";--- End of G-code ---"]
    return lines


def json_to_gcode(json_path, gcode_path):
    with open(json_path) as f:
        data = json.load(f)
    info = data.get("grid_info", {})
    path = merge_moves(simplify_travel([(p[0], p[1], p[2]) for p in data["path"]]), SMOOTHING_CELLS)
    lines = to_gcode(path, info.get("cell_size_mm", C.CELL_MM), info.get("padded_shape", [None])[0])
    with open(gcode_path, "w", newline="\n") as f:
        f.write("\n".join(lines))
    return gcode_path


if __name__ == "__main__":
    os.makedirs(os.path.dirname(OUTPUT), exist_ok=True)
    print(json_to_gcode(PATH_JSON, OUTPUT))
