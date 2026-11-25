"""Layer masks and their shape complexity.

complexity_ratio = P / (2 sqrt(pi A)): the outline length of the layer (islands and holes)
over the circumference of a disc with the same area. It is 1 for a disc. The outline is the
0.5 iso-contour of the cell mask, so a 45 degree edge counts its length, not its staircase.
"""

import math
import os
from pathlib import Path

import numpy as np
import pandas as pd
from PIL import Image
from skimage import measure

from config import CELL_MM, CLASS_BOUNDS, CLASSES


def read_mask(path):
    return np.array(Image.open(path).convert("L")) > 127


def complexity_class(ratio):
    return next(name for name, upper in zip(CLASSES, CLASS_BOUNDS) if ratio < upper)


def perimeter_cells(mask):
    padded = np.pad(np.asarray(mask, dtype=float), 1)
    return float(sum(np.hypot(*np.diff(c, axis=0).T).sum() for c in measure.find_contours(padded, 0.5)))


def shape_metrics(mask, cell_mm=CELL_MM):
    mask = np.asarray(mask) > 0
    area = float(mask.sum()) * cell_mm ** 2
    perimeter = perimeter_cells(mask) * cell_mm
    ratio = perimeter / (2 * math.sqrt(math.pi * area)) if area else 0.0
    return {"area_mm2": round(area, 3), "perimeter_mm": round(perimeter, 3),
            "pa_ratio": round(perimeter / area, 4) if area else 0.0,
            "complexity_ratio": round(ratio, 4), "complexity_class": complexity_class(ratio)}


def manifest(folder):
    """Manifest of a slice folder with the layer name ('image_<n>') and its class subfolder ('' if flat)."""
    m = pd.read_csv(os.path.join(folder, "manifest.csv"))
    m["layer"] = [Path(f).stem for f in m["file"]]
    m["subfolder"] = [str(Path(f).parent) if "/" in f else "" for f in m["file"]]
    return m
