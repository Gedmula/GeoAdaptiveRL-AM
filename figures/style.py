"""Figure style of the article: 7 pt Arial, thin axes, RL in one strong colour.

save() writes a figure as Fig <n>.pdf, .png (600 dpi) and .tif. Before each file is written, text that would
print smaller than LO pt at the figure's width in the article is set to TARGET pt; nothing else changes.
"""

import os

import matplotlib as mpl
import matplotlib.pyplot as plt
from matplotlib import rcParams
from matplotlib.text import Text
from matplotlib.transforms import Bbox

MM = 1 / 25.4
RL = '#1b4f8a'
SIZE_COLORS = ['#E69F00', '#009E73', '#CC79A7', '#0072B2']    # Grid sizes 100, 200, 400, 500 (Okabe-Ito).
SIZE_MARKERS = ['o', 's', '^', 'D']
REF = '#7a7a7a'
INK = '#1a1a1a'
GRID = '#e9e9e9'
LO, TARGET = 6.5, 6.6            # Smallest printed text size (pt) and the size smaller text is set to.


def size(width_mm, height_mm):
    return (width_mm * MM, height_mm * MM)


def apply():
    mpl.rcParams.update({
        'font.family': 'Arial', 'font.size': 7, 'axes.labelsize': 7, 'axes.titlesize': 7,
        'xtick.labelsize': 6.5, 'ytick.labelsize': 6.5, 'legend.fontsize': 6.5,
        'axes.linewidth': 0.6, 'axes.edgecolor': INK, 'axes.labelcolor': INK, 'text.color': INK,
        'xtick.color': INK, 'ytick.color': INK,
        'xtick.major.width': 0.6, 'ytick.major.width': 0.6, 'xtick.major.size': 2.5, 'ytick.major.size': 2.5,
        'xtick.minor.width': 0.4, 'ytick.minor.width': 0.4, 'xtick.minor.size': 1.5, 'ytick.minor.size': 1.5,
        'xtick.direction': 'out', 'ytick.direction': 'out',
        'axes.spines.top': False, 'axes.spines.right': False,
        'axes.grid': False, 'lines.linewidth': 0.9, 'patch.linewidth': 0.6,
        'legend.frameon': False, 'legend.handlelength': 1.4, 'legend.borderaxespad': 0.2,
        'savefig.dpi': 600, 'savefig.bbox': 'tight', 'savefig.pad_inches': 0.02,
        'pdf.fonttype': 42, 'ps.fonttype': 42, 'mathtext.fontset': 'custom', 'mathtext.rm': 'Arial',
        'mathtext.it': 'Arial:italic',
    })


def letter(ax, text, x=-0.16, y=1.04):
    """Bold panel letter at the top left of an axes."""
    ax.text(x, y, text, transform=ax.transAxes, fontsize=8, fontweight='bold', va='bottom', ha='left')


def _saved_width_in(fig, kw):
    bbox = kw.get('bbox_inches', rcParams['savefig.bbox'])
    if isinstance(bbox, Bbox):
        return bbox.width
    if bbox in (None, 'standard'):
        return fig.get_figwidth()
    fig.canvas.draw()
    tb = fig.get_tightbbox(fig.canvas.get_renderer())
    pad = kw.get('pad_inches', rcParams['savefig.pad_inches'])
    return tb.width + 2 * (0 if pad == 'layout' else pad)


def _legible(fig, width_mm, kw):
    for _ in range(6):
        scale = width_mm / 25.4 / _saved_width_in(fig, kw)          # Figure points -> printed points.
        changed = False
        for t in fig.findobj(Text):
            if not t.get_visible() or not t.get_text().strip():
                continue
            if t.get_fontsize() * scale < LO - 1e-6:
                t.set_fontsize(TARGET / scale)
                changed = True
        if not changed:
            break


def save(fig, folder, number, width_mm):
    """Write Fig <number>.pdf/.png/.tif; width_mm is the figure's width in the article."""
    os.makedirs(folder, exist_ok=True)
    for ext in ('pdf', 'png', 'tif'):
        kw = {'pil_kwargs': {'compression': 'tiff_lzw'}} if ext == 'tif' else {}
        _legible(fig, width_mm, kw)
        fig.savefig(os.path.join(folder, f'Fig {number}.{ext}'), **kw)
    plt.close(fig)
