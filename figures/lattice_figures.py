"""Figures 14-18 of the article (Physical Validation): the Schwarz-P lattices, their G-code and the printed parts.

  Fig 14  (a) single-cell and (b) multi-cell lattice as modelled (figures/inputs/stl), same view and scale
  Fig 15  (a) G-code of layer 25 of the single-cell lattice printed alone, (b) photograph of the printed layer turned
          to the toolpath's orientation, (c), (d) the framed window of (a) and (b)
  Fig 16  the same for layer 63 of the multi-cell lattice
  Fig 17  (a) print moves of every fifth layer of the single-cell part G-code, (b)-(f) photographs and video frames
  Fig 18  the same for the multi-cell lattice

Inputs: gcode/lattices/, and the models, the slice outlines of layers 25 and 63 and the photographs in
figures/inputs/. Output: results/reproduced/figures/Fig <n>.pdf, .png, .tif. Edit the settings below and run:

    python figures/lattice_figures.py
"""

import json
import os
import sys

import cv2
import numpy as np
import matplotlib.pyplot as plt
from matplotlib.collections import LineCollection
from matplotlib.colors import LinearSegmentedColormap
from matplotlib.patches import Rectangle
from mpl_toolkits.mplot3d.art3d import Line3DCollection

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(HERE), 'analysis'))

import config as C  # noqa: E402
import style as J  # noqa: E402

# === SETTINGS ===
FIGURES = (14, 15, 16, 17, 18)
OUT = os.path.join(C.REPRODUCED, 'figures')

INPUTS = os.path.join(HERE, 'inputs')
LATTICES = os.path.join(C.ROOT, 'gcode', 'lattices')
STLS = (os.path.join(INPUTS, 'stl', 'schwarz_p.stl'), os.path.join(INPUTS, 'stl', 'schwarz_p_3x3x3.stl'))
SHIFT = (100.0, 80.0)            # Bed position of the part origin in the G-code.
BOX = 50.0                       # Part size (mm).
TRAVEL = '#C0392B'
CONTOUR = '#7a7a7a'
WIDTH_MM = {14: 120.0, 15: 160.0, 16: 160.0, 17: 150.0, 18: 150.0}   # Widths in the article.

# Printed layers: G-code, outline, photograph, magnified window (x0, x1, y0, y1 in part mm) and its ticks.
SINGLE_LAYER = dict(gcode=os.path.join(LATTICES, 'schwarz_p_single_cell', 'single_layer', 'schwarz_p_layer_25.gcode'),
                    outline=os.path.join(INPUTS, 'outlines', 'schwarz_p_layer_25.json'),
                    photo=os.path.join(INPUTS, 'photos', 'single_cell', '20261114_164831.jpg'),
                    window=(8.0, 22.0, 28.0, 42.0), ticks=((10, 15, 20), (30, 35, 40)))
MULTI_LAYER = dict(gcode=os.path.join(LATTICES, 'schwarz_p_3x3x3', 'single_layer', 'schwarz_p_3x3x3_layer_63.gcode'),
                   outline=os.path.join(INPUTS, 'outlines', 'schwarz_p_3x3x3_layer_63.json'),
                   photo=os.path.join(INPUTS, 'photos', 'multi_cell', '20261114_215005.jpg'),
                   window=(6.7, 26.7, 15.0, 35.0), ticks=((10, 15, 20, 25), (15, 20, 25, 30, 35)))
SINGLE_PART = os.path.join(LATTICES, 'schwarz_p_single_cell', 'full_part', 'schwarz_p_greedy.gcode')
MULTI_PART = os.path.join(LATTICES, 'schwarz_p_3x3x3', 'full_part', 'schwarz_p_3x3x3_greedy.gcode')


def save(fig, number):
    J.save(fig, OUT, number, WIDTH_MM[number])


def gcode_moves(path, shift=SHIFT):
    """Print and travel segments [(x0, y0, z, x1, y1)] of a G-code in part mm (absolute E)."""
    prints, travels = [], []
    x = y = z = e = 0.0
    with open(path) as fh:
        for line in fh:
            if not line.startswith(('G1', 'G0')):
                continue
            words = dict((w[0], float(w[1:])) for w in line.split(';')[0].split()[1:] if w[0] in 'XYZEF')
            nx, ny, nz, ne = words.get('X', x), words.get('Y', y), words.get('Z', z), words.get('E', e)
            if ('X' in words or 'Y' in words) and (nx, ny) != (x, y):
                seg = (x - shift[0], y - shift[1], nz, nx - shift[0], ny - shift[1])
                (prints if ne > e + 1e-6 else travels).append(seg)
            x, y, z, e = nx, ny, nz, ne
    return np.array(prints), np.array(travels)


def layer_photo(path):
    """The layer photograph turned to the toolpath's orientation and cropped to the part (its blue pixels fill the
    50 mm box of the slice), and its pixels per mm."""
    im = cv2.imread(path)
    im = cv2.rotate(im, cv2.ROTATE_90_COUNTERCLOCKWISE)
    hsv = cv2.cvtColor(im, cv2.COLOR_BGR2HSV)
    blue = ((hsv[..., 0] > 100) & (hsv[..., 0] < 130) & (hsv[..., 1] > 120) & (hsv[..., 2] > 60)).astype(np.uint8)
    blue = cv2.morphologyEx(blue, cv2.MORPH_OPEN, np.ones((5, 5), np.uint8))
    ys, xs = np.nonzero(blue)
    x0, x1 = np.percentile(xs, 0.05), np.percentile(xs, 99.95)
    y0, y1 = np.percentile(ys, 0.05), np.percentile(ys, 99.95)
    crop = im[int(y0):int(y1), int(x0):int(x1)]
    return cv2.cvtColor(crop, cv2.COLOR_BGR2RGB), (x1 - x0) / BOX


def hdr_to_sdr(bgr, white_nits=300.0):
    """sRGB image of a frame of the HDR10 video (BT.2020 primaries, PQ transfer), which OpenCV decodes as BT.601
    without tone mapping: back to BT.2020 Y'CbCr, PQ to nits, white_nits to diffuse white, BT.709 primaries,
    highlight roll-off, sRGB."""
    ycc = cv2.cvtColor(bgr, cv2.COLOR_BGR2YCrCb).astype(np.float64) / 255
    y, pr, pb = ycc[..., 0], ycc[..., 1] - 0.5, ycc[..., 2] - 0.5
    kr, kb = 0.2627, 0.0593
    r, b = y + 2 * (1 - kr) * pr, y + 2 * (1 - kb) * pb
    rgb = np.stack([r, (y - kr * r - kb * b) / (1 - kr - kb), b], -1)
    m1, m2, c1, c2, c3 = 0.1593017578125, 78.84375, 0.8359375, 18.8515625, 18.6875
    e = np.power(np.clip(rgb, 0, 1), 1 / m2)
    lin = 10000 * np.power(np.maximum(e - c1, 0) / (c2 - c3 * e), 1 / m1) / white_nits
    to709 = np.array([[1.6605, -0.5876, -0.0728], [-0.1246, 1.1329, -0.0083], [-0.0182, -0.1006, 1.1187]])
    lin = np.clip(lin @ to709.T, 0, None)
    lin = np.clip(lin / (1 + lin / 4) * 1.25, 0, 1)
    srgb = np.where(lin <= 0.0031308, 12.92 * lin, 1.055 * np.power(lin, 1 / 2.4) - 0.055)
    return cv2.cvtColor((srgb * 255).astype(np.uint8), cv2.COLOR_RGB2BGR)


def dim(bgr, value=0.85, gamma=1.5, saturation=1.15):
    """Darker, more saturated close view (its specular highlights look brighter than the photographs)."""
    hsv = cv2.cvtColor(bgr, cv2.COLOR_BGR2HSV).astype(np.float64)
    hsv[..., 2] = 255 * np.power(hsv[..., 2] / 255, gamma) * value
    hsv[..., 1] = hsv[..., 1] * saturation
    return cv2.cvtColor(np.clip(hsv, 0, 255).astype(np.uint8), cv2.COLOR_HSV2BGR)


def square(path, centre, side, hdr=False, darker=False):
    """Square crop (side px) of a photograph or video frame around centre (x, y) px, in RGB."""
    im = cv2.imread(path)
    cx, cy = centre
    h = side // 2
    im = im[cy - h:cy + h, cx - h:cx + h]
    im = hdr_to_sdr(im) if hdr else im
    return cv2.cvtColor(dim(im) if darker else im, cv2.COLOR_BGR2RGB)


def scale_bar(ax, mm, px_per_mm, img_w, img_h, label):
    x1 = img_w * 0.95
    y = img_h * 0.95
    ax.plot([x1 - mm * px_per_mm, x1], [y, y], color='white', lw=2.0, solid_capstyle='butt')
    ax.text(x1 - mm * px_per_mm / 2, y - img_h * 0.025, label, color='white', ha='center', va='bottom', fontsize=6.5)


def toolpath_axes(ax, prints, travels, contours, extent):
    x0, x1, y0, y1 = extent
    for c in contours:
        c = np.asarray(c)
        ax.plot(np.r_[c[:, 0], c[0, 0]], np.r_[c[:, 1], c[0, 1]], color=CONTOUR, lw=0.4)
    ax.add_collection(LineCollection(prints[:, [0, 1, 3, 4]].reshape(-1, 2, 2), colors=J.RL, linewidths=0.35))
    if len(travels):
        ax.add_collection(LineCollection(travels[:, [0, 1, 3, 4]].reshape(-1, 2, 2), colors=TRAVEL,
                                         linewidths=0.4, linestyles=(0, (2, 1.5))))
    ax.set_xlim(x0, x1)
    ax.set_ylim(y0, y1)
    ax.set_aspect('equal')


def fig_printed_layer(layer, number):
    with open(layer['outline']) as fh:
        contours = json.load(fh)['contours']
    prints, travels = gcode_moves(layer['gcode'])
    travels = travels[(travels[:, [0, 3]].min(1) > -1) & (travels[:, [0, 3]].max(1) < BOX + 1)
                      & (travels[:, [1, 4]].min(1) > -1) & (travels[:, [1, 4]].max(1) < BOX + 1)]   # No purge line.
    prints = prints[(prints[:, [0, 3]].min(1) > -1) & (prints[:, [1, 4]].min(1) > -1)]
    photo, ppm = layer_photo(layer['photo'])
    h, w = photo.shape[:2]
    x0, x1, y0, y1 = layer['window']
    ticks = layer['ticks']

    fig, axes = plt.subplots(1, 4, figsize=J.size(190, 52), gridspec_kw={'wspace': 0.28})
    a, b, c, d = axes
    toolpath_axes(a, prints, travels, contours, (0, BOX, 0, BOX))
    a.set_xlabel('x (mm)')
    a.set_ylabel('y (mm)')
    a.add_patch(Rectangle((x0, y0), x1 - x0, y1 - y0, fill=False, ec=J.INK, lw=0.7))

    b.imshow(photo)
    b.add_patch(Rectangle((x0 * ppm, (BOX - y1) * ppm), (x1 - x0) * ppm, (y1 - y0) * ppm, fill=False, ec='white',
                          lw=0.7))
    scale_bar(b, 10, ppm, w, h, '10 mm')

    toolpath_axes(c, prints, travels, contours, layer['window'])
    c.set_xticks(ticks[0])
    c.set_yticks(ticks[1])
    c.set_xlabel('x (mm)')
    c.set_ylabel('y (mm)')

    zoom = photo[int((BOX - y1) * ppm):int((BOX - y0) * ppm), int(x0 * ppm):int(x1 * ppm)]
    d.imshow(zoom)
    bar = 5 if x1 - x0 > 15 else 2                         # About a quarter of the window.
    scale_bar(d, bar, ppm, zoom.shape[1], zoom.shape[0], f'{bar} mm')
    for ax in (b, d):
        ax.set_xticks([])
        ax.set_yticks([])
        for s in ax.spines.values():
            s.set_visible(False)
    for ax, k in zip(axes, 'abcd'):
        J.letter(ax, k, x=-0.30 if ax in (a, c) else -0.06)
    save(fig, number)


def render_stl(path, size=1600):
    """Shaded image of a model inside the outline of the 50 mm cube (pyvista, off screen, parallel projection)."""
    import pyvista as pv
    plot = pv.Plotter(off_screen=True, window_size=(size, size))
    plot.set_background('white')
    plot.add_mesh(pv.read(path), color='#3b73b5', smooth_shading=True, specular=0.25, ambient=0.25, diffuse=0.8)
    plot.add_mesh(pv.Box((0, BOX, 0, BOX, 0, BOX)).extract_feature_edges(), color='#9a9a9a', line_width=2)
    plot.camera_position = [(BOX / 2 + 95, BOX / 2 - 120, BOX / 2 + 70), (BOX / 2,) * 3, (0, 0, 1)]
    plot.enable_parallel_projection()
    plot.camera.parallel_scale = 0.86 * BOX
    plot.enable_anti_aliasing('ssaa')
    img = plot.screenshot(return_img=True)
    plot.close()
    return img


def fig_test_lattices():
    fig, axes = plt.subplots(1, 2, figsize=J.size(150, 74), gridspec_kw={"wspace": 0.04})
    for ax, path, k in zip(axes, STLS, 'ab'):
        ax.imshow(render_stl(path))
        ax.set_xticks([])
        ax.set_yticks([])
        for sp in ax.spines.values():
            sp.set_visible(False)
        J.letter(ax, k, x=0.02, y=0.96)
    save(fig, 14)


def single_cell_panels():
    """Front, oblique and top views and close views of a node and a tunnel (crops of a video frame)."""
    p = lambda f: os.path.join(INPUTS, 'photos', 'single_cell', f)
    return [square(p('20261114_165059.jpg'), (3850, 1700), 2800),
            square(p('20261114_165105.jpg'), (3630, 2300), 2800),
            square(p('20261114_164955_frame_0030.png'), (1000, 1800), 1700, hdr=True),
            square(p('20261114_164955_frame_0147.png'), (1320, 1600), 1000, hdr=True, darker=True),
            square(p('20261114_164955_frame_0147.png'), (1750, 2100), 900, hdr=True, darker=True)]


def multi_cell_panels():
    """Front, oblique and top views and close views of a tunnel on the front face and of a side face."""
    p = lambda f: os.path.join(INPUTS, 'photos', 'multi_cell', f)
    return [square(p('20261114_215029.jpg'), (1915, 960), 1250),
            square(p('20261114_215035.jpg'), (2440, 1150), 1300),
            square(p('20261114_215053.jpg'), (1790, 960), 1100),
            square(p('20261114_215029.jpg'), (1915, 1180), 460),
            square(p('20261114_215046.jpg'), (1720, 900), 460)]


def fig_printed_part(gcode, panels, number):
    prints, _ = gcode_moves(gcode)
    prints = prints[(prints[:, [0, 3]].min(1) > -1) & (prints[:, [1, 4]].min(1) > -1)]
    layer = np.rint(prints[:, 2] / 0.2).astype(int)
    keep = prints[(layer % 5 == 0) | (layer == 1)]
    segs = np.stack([keep[:, [0, 1, 2]], keep[:, [3, 4, 2]]], axis=1)
    cmap = LinearSegmentedColormap.from_list('rl', ['#cfdcec', J.RL])

    fig = plt.figure(figsize=J.size(190, 128))
    gs = fig.add_gridspec(2, 3, wspace=0.10, hspace=0.10)
    a = fig.add_subplot(gs[0, 0], projection='3d')
    a.add_collection3d(Line3DCollection(segs, colors=cmap(keep[:, 2] / BOX), linewidths=0.2))
    a.set_xlim(0, BOX)
    a.set_ylim(0, BOX)
    a.set_zlim(0, BOX)
    a.set_box_aspect((1, 1, 1), zoom=0.86)
    a.view_init(elev=22, azim=-60)
    a.set_xlabel('x (mm)', labelpad=-6)
    a.set_ylabel('y (mm)', labelpad=-6)
    a.set_zlabel('z (mm)', labelpad=-6)
    a.tick_params(pad=-3, labelsize=6)
    a.set_xticks([0, 25, 50])
    a.set_yticks([0, 25, 50])
    a.set_zticks([0, 25, 50])
    for pane in (a.xaxis, a.yaxis, a.zaxis):
        pane.set_pane_color((1, 1, 1, 0))
        pane._axinfo['grid']['color'] = J.GRID
    a.text2D(0.0, 0.98, 'a', transform=a.transAxes, fontsize=8, fontweight='bold', va='bottom', ha='left')
    for k, (img, pos) in enumerate(zip(panels, [(0, 1), (0, 2), (1, 0), (1, 1), (1, 2)])):
        ax = fig.add_subplot(gs[pos])
        ax.imshow(img)
        ax.set_xticks([])
        ax.set_yticks([])
        for s in ax.spines.values():
            s.set_visible(False)
        J.letter(ax, 'bcdef'[k], x=0.0, y=1.01)
    save(fig, number)


RENDER = {14: fig_test_lattices,
          15: lambda: fig_printed_layer(SINGLE_LAYER, 15),
          16: lambda: fig_printed_layer(MULTI_LAYER, 16),
          17: lambda: fig_printed_part(SINGLE_PART, single_cell_panels(), 17),
          18: lambda: fig_printed_part(MULTI_PART, multi_cell_panels(), 18)}

if __name__ == '__main__':
    J.apply()
    for n in FIGURES:
        RENDER[n]()
        print(f'Fig {n}', flush=True)
