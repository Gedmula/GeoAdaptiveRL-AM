"""Figures 7-13 of the article (Results and Analysis) from the tables, slices and G-code of this repository.

  Fig 7   fill measurement by bead sweeping: bead cross-section and the swept print moves over a slice
  Fig 8   generalization: test - training gap per training grid (train_test_gap.csv); completion and slice
          quality against the complexity ratio on the test slices (transfer_per_layer.csv, transfer_fits.csv)
  Fig 9   Bland-Altman plot of G-code fill against rollout coverage (coverage_fill.csv)
  Fig 10  median and interquartile range of every toolpath (per_slice_metrics.csv)
  Fig 11  paired differences RL - pattern over the compared slices (paired.csv)
  Fig 12  deposited region of RL and the five patterns on a simple, a complex and an extreme slice, from the G-code
  Fig 13  paired differences RL - pattern per complexity class (paired.csv)

Output: results/reproduced/figures/Fig <n>.pdf, .png, .tif. The text is set in Arial. Edit the settings below
and run:

    python figures/results_figures.py
"""

import os
import sys

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from matplotlib.lines import Line2D
from matplotlib.patches import Patch

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(HERE), 'analysis'))

import config as C  # noqa: E402
import style as J  # noqa: E402

# === SETTINGS ===
FIGURES = (7, 8, 9, 10, 11, 12, 13)
OUT = os.path.join(C.REPRODUCED, 'figures')

SIZES = (100, 200, 400, 500)
CLASSES = ['simple', 'moderate', 'complex', 'very_complex', 'extreme']
SHORT = ['S', 'M', 'C', 'VC', 'E']
CLASS_LABELS = ['Simple', 'Moderate', 'Complex', 'Very complex', 'Extreme']
SOLID = list(C.SOLID)
LABEL = {'rectilinear': 'Rectilinear', 'concentric': 'Concentric', 'hilbertcurve': 'Hilbert curve',
         'archimedeanchords': 'Archimedean chords', 'octagramspiral': 'Octagram spiral'}
PAT_C = {'rectilinear': '#D55E00', 'concentric': '#009E73', 'hilbertcurve': '#E69F00', 'archimedeanchords': '#CC79A7',
         'octagramspiral': '#56B4E9'}
PAT_M = {'rectilinear': 's', 'concentric': 'o', 'hilbertcurve': '^', 'archimedeanchords': 'D', 'octagramspiral': 'v'}
OUTCOME = {'superior': J.RL, 'inferior': '#C0392B', 'equivalent': '#8C8C8C', 'inconclusive': '#FFFFFF'}
SIZE_C = dict(zip(SIZES, J.SIZE_COLORS))
SIZE_M = dict(zip(SIZES, J.SIZE_MARKERS))
WIDTH_MM = {7: 160.0, 8: 137.9, 9: 90.0, 10: 160.0, 11: 160.0, 12: 140.7, 13: 160.0}   # Widths in the article.


def save(fig, number):
    J.save(fig, OUT, number, WIDTH_MM[number])


def test_slices():
    t = pd.read_csv(C.source('transfer', 'transfer_per_layer.csv'))
    t['completed'] = t.outcome == 'completed'
    return t


# ========================================================================
# FIG 8: GENERALIZATION
# ========================================================================

GAPS = [('completed', 'Completed slices (pp)', 'a'), ('coverage', 'Coverage ζ (pp)', 'b'),
        ('Q', 'Slice quality $q_S$', 'c'), ('starts_cm2', 'Extrusion starts (1/cm²)', 'd')]


def fmt_p(p):
    return 'p < 0.001' if p < 0.001 else f'p = {p:.3f}' if p < 0.01 else f'p = {p:.2f}'


def binned(g, col, k=6):
    """Median CR and statistic of `col` (rate for completion, median otherwise) per CR sextile."""
    bins = np.quantile(g.complexity_ratio, np.linspace(0, 1, k + 1))
    idx = np.clip(np.digitize(g.complexity_ratio, bins[1:-1]), 0, k - 1)
    out = []
    for b in range(k):
        sel = g[idx == b]
        if len(sel):
            v = 100 * sel[col].mean() if col == 'completed' else sel[col].median()
            out.append((sel.complexity_ratio.median(), v))
    return np.array(out)


def generalization():
    t = test_slices()
    gap = pd.read_csv(C.source('generalization', 'train_test_gap.csv'))
    TR = (100, 200, 400)
    fig = plt.figure(figsize=J.size(190, 118))
    gs = fig.add_gridspec(2, 4, height_ratios=[1, 1.15], hspace=0.62, wspace=0.62)
    for k, (metric, lab, lt) in enumerate(GAPS):                  # (a)-(d): test - training gap per training grid
        ax = fig.add_subplot(gs[0, k])
        ax.axhline(0, color=J.REF, lw=0.5)
        g = gap[gap.metric == metric].set_index('size')
        for i, s in enumerate(TR):
            r = g.loc[s]
            ax.vlines(i, r.lo, r.hi, color=SIZE_C[s], lw=0.9)
            ax.plot(i, r.gap, SIZE_M[s], ms=4, color=SIZE_C[s], mec='white', mew=0.4, zorder=3)
            sig = r.p_holm < 0.05
            ax.text(i, 0.97, fmt_p(r.p_holm).replace(' ', '').replace('p=', ''), ha='center', va='top',
                    fontsize=5.4, transform=ax.get_xaxis_transform(), color=J.INK if sig else '#666666',
                    fontweight='bold' if sig else 'normal')
        ax.text(-0.57, 0.97, 'p', ha='left', va='top', fontsize=5.4, style='italic', color='#666666',
                transform=ax.get_xaxis_transform())
        lim = max(g[['lo', 'hi']].abs().max()) * 1.7
        ax.set_ylim(-lim, lim)
        ax.set_xticks(range(len(TR)), ['100', '200', '400']); ax.set_xlim(-0.6, len(TR) - 0.4)
        ax.set_xlabel('Training slice size'); ax.set_title(lab, fontsize=6.8, pad=4)
        if k == 0:
            ax.set_ylabel('Test − training')
        J.letter(ax, lt, x=-0.42, y=1.12)

    fits = pd.read_csv(C.source('transfer', 'transfer_fits.csv')).set_index('size')
    for k, (col, lab, lt) in enumerate((('completed', 'Completed slices (%)', 'e'), ('Q', 'Slice quality $q_S$', 'f'))):
        ax = fig.add_subplot(gs[1, 2 * k:2 * k + 2])               # (e), (f): against complexity ratio, test slices
        for s in SIZES:
            g = t[t['size'] == s]
            b = binned(g, col)
            if col == 'completed':
                cr = np.geomspace(g.complexity_ratio.min(), g.complexity_ratio.max(), 200)
                b0, b1 = fits.loc[s, 'logit_b0'], fits.loc[s, 'logit_b1_log_cr']
                ax.plot(cr, 100 / (1 + np.exp(-(b0 + b1 * np.log(cr)))), color=SIZE_C[s], lw=0.9)
                ax.plot(b[:, 0], b[:, 1], SIZE_M[s], ls='', ms=3.6, color=SIZE_C[s], mec='white', mew=0.4)
            else:
                ax.plot(b[:, 0], b[:, 1], SIZE_M[s], ls='-', lw=0.8, ms=3.6, color=SIZE_C[s], mec='white', mew=0.4)
        ax.set_xscale('log'); ax.set_xticks([1, 2, 4, 8, 15], ['1', '2', '4', '8', '15'])
        ax.set_xlabel('Complexity ratio CR'); ax.set_ylabel(lab)
        grey = '#555555'
        if col == 'completed':
            ax.set_ylim(40, 103)
            key = [Line2D([], [], color=grey, lw=0.9), Line2D([], [], color=grey, marker='o', ls='', ms=3.6, mec='white')]
            ax.legend(key, ['Logistic fit', 'Share completed per CR sextile'], loc='lower left')
        else:
            key = [Line2D([], [], color=grey, marker='o', lw=0.8, ms=3.6, mec='white')]
            ax.legend(key, ['Median per CR sextile'], loc='lower left')
        J.letter(ax, lt, x=-0.17, y=1.06)
    hs = [Line2D([], [], color=SIZE_C[s], marker=SIZE_M[s], ms=4, mec='white', mew=0.4, lw=0.9) for s in SIZES]
    fig.legend(hs, [f'{s}×{s}' + (' (not in training)' if s == 500 else '') for s in SIZES], ncol=4,
               loc='lower center', bbox_to_anchor=(0.5, -0.06), title='Slice size', title_fontsize=6.5)
    save(fig, 8)


# ========================================================================
# FIG 9: COVERAGE AGAINST FILL
# ========================================================================

def agreement():
    d = pd.read_csv(C.source('coverage_fill', 'coverage_fill.csv'))
    dev = d.fill_pct - d.coverage_pct
    mean = (d.fill_pct + d.coverage_pct) / 2
    fig, ax = plt.subplots(figsize=J.size(90, 62))
    for s in SIZES:
        sel = (d['size'] == s) & (mean >= 96)
        ax.scatter(mean[sel], dev[sel], s=3.5, lw=0, color=SIZE_C[s], alpha=0.8, label=f'{s}×{s}', rasterized=True)
    bias, sd = dev.mean(), dev.std()
    for y, ls in ((bias, '-'), (bias + 1.96 * sd, (0, (4, 2))), (bias - 1.96 * sd, (0, (4, 2)))):
        ax.axhline(y, color=J.INK, lw=0.6, ls=ls)
    x0 = 96.0                                                   # Slices with a lower mean fill are not drawn.
    x1 = np.ceil(mean.max() * 2) / 2 + 0.1
    fmt = lambda v: f'{v:+.2f}'.replace('-', '−')
    for y, lab in ((bias, 'bias'), (bias + 1.96 * sd, '+1.96 SD'), (bias - 1.96 * sd, '−1.96 SD')):
        ax.text(x1 - 0.05, y + 0.06, f'{lab} {fmt(y)}', fontsize=6, ha='right', va='bottom')
    ax.set(xlim=(x0, x1), xlabel=r'Mean fill $\bar{F}$ (%)', ylabel=r'Fill deviation $\Delta F$ (pp)')
    ax.legend(title='Slice size', loc='upper left', markerscale=2.2, ncol=4, columnspacing=0.6, title_fontsize=6.5,
              handletextpad=0.2, bbox_to_anchor=(0.0, 1.13), frameon=False)
    save(fig, 9)


# ========================================================================
# FIG 11: PAIRED DIFFERENCES
# ========================================================================

FOREST = [('time_per_cm2', 'Print time (%)', 0.05, True), ('starts_per_cm2', 'Extrusion starts (%)', 0.10, True),
          ('travel_per_cm2', 'Travel (mm/cm²)', None, False), ('fill_pct', 'Fill (pp)', 1.0, False),
          ('edge_fill_pct', 'Edge fill (pp)', 1.0, False), ('overspill_pct', 'Overspill (pp)', 1.0, False)]


def forest():
    p = pd.read_csv(C.source('baseline_comparison', 'paired.csv'))
    p = p[p.cls == 'all']
    fig, axs = plt.subplots(1, 6, figsize=J.size(190, 46), sharey=True, gridspec_kw={'wspace': 0.2})
    y = np.arange(len(SOLID))[::-1]
    for ax, (m, lab, margin, rel), lt in zip(axs, FOREST, 'abcdef'):
        if margin:
            mg = 100 * margin if rel else margin
            ax.axvspan(-mg, mg, color='#ececec', lw=0, zorder=0)
        ax.axvline(0, color=J.REF, lw=0.5, zorder=1)
        for yy, pat in zip(y, SOLID):
            r = p[(p.metric == m) & (p.pattern == pat)]
            if not len(r):
                ax.text(0, yy, '–', ha='center', va='center', fontsize=6, color='#999999')
                continue
            r = r.iloc[0]
            e, lo, hi = (r.est_rel, r.lo_rel, r.hi_rel) if rel else (r.est, r.lo, r.hi)
            ax.hlines(yy, lo, hi, color=J.INK, lw=0.7, zorder=2)
            ax.plot(e, yy, 'o', ms=3.6, mfc=OUTCOME[r.outcome], mec=J.INK, mew=0.5, zorder=3)
        ax.set_title(lab, fontsize=6.8, pad=3)
        ax.tick_params(axis='y', length=0)
        ax.set_ylim(-0.6, len(SOLID) - 0.4)
        if m == 'starts_per_cm2':
            ax.set_xticks([-80, 0, 80])
        J.letter(ax, lt, x=-0.05 if lt != 'a' else -1.05, y=1.07)
    axs[0].set_yticks(y, [LABEL[q] for q in SOLID])
    handles = [Line2D([], [], marker='o', ls='', mfc=c, mec=J.INK, mew=0.5, ms=4) for c in OUTCOME.values()]
    fig.legend(handles + [Patch(color='#ececec')], ['RL superior', 'RL inferior', 'Equivalent', 'Inconclusive',
               'Equivalence margin'], ncol=5, loc='lower center', bbox_to_anchor=(0.5, -0.12))
    fig.text(0.5, -0.18, 'RL − pattern (Hodges–Lehmann estimate, 95% CI)', ha='center', fontsize=6.5)
    save(fig, 11)


# ========================================================================
# FIG 10: TOOLPATH SUMMARY
# ========================================================================

# (column, title, log axis, x ticks, x limits)
SUMMARY = [[('time_per_cm2', 'Print time (s/cm²)', False, [3.5, 4, 4.5, 5, 5.5], None),
            ('starts_per_cm2', 'Extrusion starts (1/cm²)', True, [1, 3, 10, 30, 100], None),
            ('travel_per_cm2', 'Travel (mm/cm²)', True, [3, 10, 30, 100], (2.5, 110)),
            ('corners_per_10mm', 'Direction changes (1/10 mm)', False, None, None)],
           [('fill_pct', 'Fill (%)', False, [88, 92, 96, 100], None),
            ('edge_fill_pct', 'Edge fill (%)', False, [20, 40, 60, 80, 100], None),
            ('void_largest_mm2', 'Largest void (mm²)', True, [0.1, 0.3, 1, 3], None),
            ('overspill_pct', 'Overspill (%)', True, [0.01, 0.1, 1, 10], None)]]


def toolpath_summary():
    from matplotlib.ticker import FixedLocator, NullFormatter
    from baseline_statistics import load
    df = load('per_slice_metrics.csv')
    order = ['RL'] + SOLID
    col, mk, lab = {'RL': J.RL, **PAT_C}, {'RL': 'o', **PAT_M}, {'RL': 'RL', **LABEL}
    fig, axs = plt.subplots(2, 4, figsize=J.size(190, 84), sharey=True, gridspec_kw={'wspace': 0.12, 'hspace': 0.62})
    y = np.arange(len(order))[::-1]
    for r, row in enumerate(SUMMARY):
        for c, (m, title, log, ticks, lim) in enumerate(row):
            ax = axs[r, c]
            ax.axvline(df[df.toolpath == 'RL'][m].median(), color=J.RL, lw=0.5, ls=(0, (2, 1.5)), zorder=1)
            for yy, t in zip(y, order):
                q1, med, q3 = np.percentile(df[df.toolpath == t][m], [25, 50, 75])
                ax.hlines(yy, q1, q3, color=col[t], lw=2.2 if t == 'RL' else 1.6, alpha=0.55, zorder=2)
                ax.plot(med, yy, mk[t], ms=4.2 if t == 'RL' else 3.6, mfc=col[t], mec='white', mew=0.4, zorder=3)
            if log:
                ax.set_xscale('log')
                ax.xaxis.set_minor_formatter(NullFormatter())
            if ticks:
                ax.xaxis.set_major_locator(FixedLocator(ticks))
                ax.set_xticklabels([f'{t:g}' for t in ticks])
            if lim:
                ax.set_xlim(*lim)
            ax.set_title(title, fontsize=6.8, pad=3)
            ax.tick_params(axis='y', length=0)
            ax.grid(axis='x', color=J.GRID, lw=0.5, zorder=0)
            J.letter(ax, 'abcdefgh'[4 * r + c], x=-0.05 if c else -0.62, y=1.06)
            if m == 'time_per_cm2':                                   # Time over its lower bound on the top axis.
                k = (df.time_over_lb / df.time_per_cm2).median()
                top = ax.secondary_xaxis('top', functions=(lambda x: x * k, lambda x: x / k))
                top.set_xticks([1.1, 1.2, 1.3, 1.4, 1.5]); top.tick_params(labelsize=5.5, length=2, pad=1)
                top.set_xlabel('Time / $T_{lb}$', fontsize=5.5, labelpad=1)
                ax.set_title(title, fontsize=6.8, pad=24)
    axs[0, 0].set_yticks(y, [lab[t] for t in order])
    for ax in axs[:, 0]:
        for lbl, t in zip(ax.get_yticklabels(), order):
            if t == 'RL':
                lbl.set_fontweight('bold'); lbl.set_color(J.RL)
    fig.text(0.5, 0.995, 'Efficiency and continuity', ha='center', fontsize=7, fontweight='bold')
    fig.text(0.5, 0.475, 'Part quality', ha='center', fontsize=7, fontweight='bold')
    save(fig, 10)


# ========================================================================
# FIG 13: PAIRED DIFFERENCES PER COMPLEXITY CLASS
# ========================================================================

COMPLEX = [('time_per_cm2', 'Print time (%)', True), ('starts_per_cm2', 'Extrusion starts (%)', True),
           ('fill_pct', 'Fill (pp)', False), ('edge_fill_pct', 'Edge fill (pp)', False)]


def complexity():
    p = pd.read_csv(C.source('baseline_comparison', 'paired.csv'))
    fig, axs = plt.subplots(1, 4, figsize=J.size(190, 60), gridspec_kw={'wspace': 0.42})
    x = np.arange(len(CLASSES))
    for ax, (m, lab, rel), lt in zip(axs, COMPLEX, 'abcd'):
        ax.axhline(0, color=J.REF, lw=0.5)
        for k, pat in enumerate(SOLID):
            r = p[(p.metric == m) & (p.pattern == pat)].set_index('cls').reindex(CLASSES)
            e, lo, hi = (r.est_rel, r.lo_rel, r.hi_rel) if rel else (r.est, r.lo, r.hi)
            xx = x + (k - (len(SOLID) - 1) / 2) * 0.06
            ax.vlines(xx, lo, hi, color=PAT_C[pat], lw=0.6)
            ax.plot(xx, e, ls='-', color=PAT_C[pat], lw=0.8, marker=PAT_M[pat], ms=3, mec='white', mew=0.3,
                    label=LABEL[pat])
        ax.set_xticks(x, SHORT); ax.set_xlabel('Complexity class'); ax.set_ylabel(f'RL − pattern: {lab}')
        J.letter(ax, lt, x=-0.36)
    h, l = axs[0].get_legend_handles_labels()
    fig.legend(h, l, loc='upper center', ncol=5, bbox_to_anchor=(0.5, 1.08), columnspacing=1.2)
    save(fig, 13)


# ========================================================================
# FIG 12: DEPOSITED REGIONS
# ========================================================================

ZOOM_MM = 5.0
# Slices whose RL fill is the median of their class (500x500 test set).
SLICES = {'simple': ('1_simple', 'image_24'), 'complex': ('3_complex', 'image_149'), 'extreme': ('5_extreme', 'image_380')}


def gcode_file(tp, sub, layer):
    grid = C.grid(C.COMPARISON_SIZE)
    if tp == 'RL':
        return os.path.join(C.RL_GCODE, grid, sub, f'{layer}.gcode')
    return os.path.join(C.BASELINE_GCODE, tp, sub, f'{layer}_{tp}.gcode')


def sweep_geometry(mask, sub, layer, tps):
    """Filled target, unfilled target, overspill and fill % of every toolpath (bead sweep)."""
    import shapely
    import bead_sweep as S
    from gcode import main_path, read_gcode_file
    out = {}
    for tp in tps:
        q = S.sweep_quality(main_path(read_gcode_file(gcode_file(tp, sub, layer))), mask, with_overlap=False,
                            return_geometry=True)
        B, T = q['B'], q['T']
        out[tp] = (shapely.intersection(B, T), shapely.difference(T, B), shapely.difference(B, T), q['fill_pct'])
    return out


def zoom_window(geo, bounds, k=ZOOM_MM, step=0.05):
    """Lower-left corner of the k x k mm window with the most unfilled target and overspill over all toolpaths."""
    import shapely
    x0, y0, x1, y1 = bounds
    xs, ys = np.arange(x0, x1, step), np.arange(y0, y1, step)
    X, Y = np.meshgrid(xs, ys)
    score = np.zeros(X.shape)
    for _, unf, ovr, _ in geo.values():
        for g in (unf, ovr):
            if not g.is_empty:
                shapely.prepare(g)
                score += shapely.contains_xy(g, X, Y)
    n = int(round(k / step))
    c = np.pad(score.cumsum(0).cumsum(1), ((1, 0), (1, 0)))
    win = c[n:, n:] - c[:-n, n:] - c[n:, :-n] + c[:-n, :-n]
    i, j = np.unravel_index(np.argmax(win), win.shape)
    return xs[j], ys[i]


def _draw(ax, geo, colour, UNF, OVR):
    from shapely.plotting import plot_polygon
    fil, unf, ovr, _ = geo
    for g, c in ((fil, colour), (unf, UNF), (ovr, OVR)):
        if not g.is_empty:
            plot_polygon(g, ax=ax, add_points=False, facecolor=c, edgecolor='none', linewidth=0)


def deposition_maps():
    from matplotlib.patches import Rectangle, ConnectionPatch
    from layers import read_mask
    UNF, OVR, PAT = '#E69F00', '#c0392b', '#4d4d4d'
    tps = ['RL'] + SOLID
    names = {'RL': 'RL', **LABEL}
    zoomed = 'extreme'
    fig = plt.figure(figsize=J.size(190, 165))
    gs = fig.add_gridspec(4, len(tps), height_ratios=[1, 1, 1, 0.62], hspace=0.3, wspace=0.06)
    for row, cls in enumerate(('simple', 'complex', 'extreme')):
        zoom = cls == zoomed
        sub, layer = SLICES[cls]
        mask = read_mask(os.path.join(C.test_folder(C.COMPARISON_SIZE), sub, f'{layer}.png'))
        geo = sweep_geometry(mask, sub, layer, tps)
        T = geo['RL'][0].union(geo['RL'][1])
        x0, y0, x1, y1 = T.bounds
        pad = 0.8
        bx = (x0 - pad, y0 - pad, x1 + pad, y1 + pad)
        zx0, zy0 = zoom_window(geo, bx) if zoom else (0, 0)
        for col, tp in enumerate(tps):
            ax = fig.add_subplot(gs[row, col])
            _draw(ax, geo[tp], J.RL if tp == 'RL' else PAT, UNF, OVR)
            ax.set_xlim(bx[0], bx[2]); ax.set_ylim(bx[1], bx[3]); ax.set_aspect('equal')
            ax.set_title(f'{names[tp]}\nfill {geo[tp][3]:.1f}%', fontsize=6.2, pad=2, linespacing=1.1)
            axes = [ax]
            if zoom:
                ax.add_patch(Rectangle((zx0, zy0), ZOOM_MM, ZOOM_MM, fill=False, ec=J.INK, lw=0.7, zorder=5))
                zx = fig.add_subplot(gs[row + 1, col])
                _draw(zx, geo[tp], J.RL if tp == 'RL' else PAT, UNF, OVR)
                zx.set_xlim(zx0, zx0 + ZOOM_MM); zx.set_ylim(zy0, zy0 + ZOOM_MM); zx.set_aspect('equal')
                axes.append(zx)
                for xa in (zx0, zx0 + ZOOM_MM):
                    fig.add_artist(ConnectionPatch((xa, zy0), (xa, zy0 + ZOOM_MM), coordsA='data', coordsB='data',
                                                   axesA=ax, axesB=zx, color='#888888', lw=0.45))
            for a in axes:
                a.set_xticks([]); a.set_yticks([])
                for sp in a.spines.values():
                    sp.set_visible(a is not ax); sp.set_linewidth(0.7)
            if col == 0:
                ax.add_patch(Rectangle((bx[0] + 0.3, bx[1] + 0.4), 5.0, 0.4, color=J.INK))
                ax.text(bx[0] + 2.8, bx[1] + 0.95, '5 mm', ha='center', va='bottom', fontsize=5.6)
                ax.text(-0.12, 0.5, f'{CLASS_LABELS[CLASSES.index(cls)]} slice', transform=ax.transAxes, rotation=90,
                        ha='center', va='center', fontsize=6.8)
                J.letter(ax, 'abc'[row], x=-0.2, y=1.08)
    hs = [plt.Rectangle((0, 0), 1, 1, color=c) for c in (J.RL, PAT, UNF, OVR)]
    fig.legend(hs, ['Filled by RL', 'Filled by the pattern', 'Unfilled target', 'Overspill'], ncol=4,
               loc='lower center', bbox_to_anchor=(0.5, 0.02))
    save(fig, 12)


# ========================================================================
# FIG 7: BEAD SWEEP SCHEMATIC
# ========================================================================

PATH_C = '#7b2d8e'


def _dim(ax, p, q, label, off=(0, 0), side='above', fs=7, ext=None, **M):
    """Dimension line between p and q with optional extension lines and a centred label."""
    from matplotlib.patches import FancyArrowPatch
    ax.add_patch(FancyArrowPatch(p, q, arrowstyle='<|-|>', mutation_scale=4.5, lw=0.5, color=J.INK,
                                 shrinkA=0, shrinkB=0, zorder=6))
    if ext:
        for (a, b) in ext:
            ax.plot(*zip(a, b), color=J.INK, lw=0.35, zorder=6)
    mx, my = (p[0] + q[0]) / 2 + off[0], (p[1] + q[1]) / 2 + off[1]
    va = {'above': 'bottom', 'below': 'top', 'right': 'center', 'left': 'center'}[side]
    ha = {'above': 'center', 'below': 'center', 'right': 'left', 'left': 'right'}[side]
    ax.text(mx, my, label, ha=ha, va=va, fontsize=fs, zorder=7, **M)


def bead_model():
    import shapely
    from shapely.plotting import plot_polygon
    from matplotlib.patches import Circle, Rectangle
    import bead_sweep as S
    w, h = 0.45, 0.2
    FILL, UNF, OVR, GRID = '#d5dde8', '#f2c46d', '#d9776b', '#d0d0d0'
    M = dict(math_fontfamily='stix')
    fig, (a1, a2) = plt.subplots(1, 2, figsize=J.size(150, 52), gridspec_kw={'width_ratios': [1, 1.9], 'wspace': 0.1})

    # (a) bead cross-section on the previous layer
    r = h / 2
    bead = shapely.unary_union([shapely.box(-w / 2 + r, -r, w / 2 - r, r),
                                shapely.Point(-w / 2 + r, 0).buffer(r, quad_segs=48),
                                shapely.Point(w / 2 - r, 0).buffer(r, quad_segs=48)])
    a1.add_patch(Rectangle((-0.34, -r - 0.07), 0.68, 0.07, facecolor='white', edgecolor=J.INK, lw=0.5,
                           hatch='////', zorder=1))
    plot_polygon(bead, ax=a1, add_points=False, facecolor=FILL, edgecolor=J.INK, linewidth=0.7, zorder=2)
    a1.text(0, 0, '$A$', ha='center', va='center', fontsize=7.5)
    yt = r + 0.07
    _dim(a1, (-w / 2, yt), (w / 2, yt), '$w$', off=(0, 0.012),
         ext=[((-w / 2, 0.0), (-w / 2, yt + 0.02)), ((w / 2, 0.0), (w / 2, yt + 0.02))])
    xr = w / 2 + 0.07
    _dim(a1, (xr, -r), (xr, r), '$h$', off=(0.015, 0), side='right',
         ext=[((w / 2 - r, r), (xr + 0.02, r)), ((w / 2 - r, -r), (xr + 0.02, -r))])
    c = (-w / 2 + r, 0)
    a1.plot(*c, 'o', ms=1.6, color=J.INK)
    a1.plot([c[0], c[0] - r * np.cos(np.pi / 4)], [0, -r * np.sin(np.pi / 4)], color=J.INK, lw=0.5)
    a1.text(c[0] + 0.012, -0.05, '$h/2$', ha='left', va='center', fontsize=6)
    a1.set_xlim(-0.36, 0.42); a1.set_ylim(-0.3, 0.25); a1.set_aspect('equal'); a1.axis('off')
    J.letter(a1, 'a', x=0.0, y=1.0)

    # (b) top view: a slice of 0.1 mm cells and a serpentine print path with lines 0.5 mm apart
    rows, cols = 19, 30
    ii, jj = np.mgrid[0:rows, 0:cols]
    X, Y = jj * 0.1, (rows - 1 - ii) * 0.1
    mask = (X >= 0.2) & (Y >= 0.2) & (Y <= 1.6) & (X <= 2.75 - 0.45 * Y)
    T = S.cells_polygon(mask)
    ys, xa = [0.4, 0.9, 1.4], 0.45
    xb = {0.4: 2.35, 0.9: 2.13, 1.4: 2.15}
    pts = []
    for k, y in enumerate(ys):
        pts += [(xa, y), (xb[y], y)] if k % 2 == 0 else [(xb[y], y), (xa, y)]
    seg = np.array([(*pts[i], *pts[i + 1], w, 0) for i in range(len(pts) - 1)])
    B = shapely.unary_union(S.capsules(seg))
    for g, col in ((shapely.intersection(B, T), FILL), (shapely.difference(T, B), UNF), (shapely.difference(B, T), OVR)):
        if not g.is_empty:
            plot_polygon(g, ax=a2, add_points=False, facecolor=col, edgecolor='none', linewidth=0, zorder=1)
    for i, j in zip(*np.nonzero(mask)):
        a2.add_patch(Rectangle((X[i, j] - 0.05, Y[i, j] - 0.05), 0.1, 0.1, fill=False, ec=GRID, lw=0.2, zorder=2))
    plot_polygon(T, ax=a2, add_points=False, facecolor='none', edgecolor=J.INK, linewidth=0.7, zorder=3)
    plot_polygon(B, ax=a2, add_points=False, facecolor='none', edgecolor='#2f4f78', linewidth=0.6, zorder=3,
                 linestyle=(0, (4, 1.5)))
    P = np.array(pts)
    a2.plot(P[:, 0], P[:, 1], color=PATH_C, lw=0.7, zorder=4)
    for i in range(len(P) - 1):                                  # Direction of travel.
        m = (P[i] + P[i + 1]) / 2
        d = (P[i + 1] - P[i]) / np.linalg.norm(P[i + 1] - P[i])
        a2.annotate('', xy=m + 0.06 * d, xytext=m - 0.06 * d,
                    arrowprops=dict(arrowstyle='-|>', lw=0.7, color=PATH_C, mutation_scale=5), zorder=5)
    p0, p1 = P[0], P[1]
    for t in (0.0, 0.42, 1.0):                                    # The footprint at three positions of a move.
        cc = p0 + t * (p1 - p0)
        a2.add_patch(Circle(cc, w / 2, fill=False, ec=J.INK, lw=0.45, ls=(0, (2, 1.2)), zorder=5))
        a2.plot(*cc, 'o', ms=1.4, color=PATH_C, zorder=6)
    cc = p0 + 0.42 * (p1 - p0)
    yb = -0.08
    _dim(a2, (cc[0] - w / 2, yb), (cc[0] + w / 2, yb), '$w$', off=(0, -0.012), side='below',
         ext=[((cc[0] - w / 2, cc[1]), (cc[0] - w / 2, yb - 0.02)), ((cc[0] + w / 2, cc[1]), (cc[0] + w / 2, yb - 0.02))])
    xs = 2.95
    _dim(a2, (xs, ys[0]), (xs, ys[1]), '0.5 mm', off=(0.03, 0), side='right', fs=6,
         ext=[((xb[0.4] + 0.25, ys[0]), (xs + 0.03, ys[0])), ((xb[0.9] + 0.3, ys[1]), (xs + 0.03, ys[1]))])
    a2.text(0.33, 1.52, r'$\mathcal{T}$', fontsize=8, ha='center', va='center', zorder=7, **M)
    a2.text(2.47, 1.66, r'$\mathcal{B}$', fontsize=8, ha='center', va='center', color='#2f4f78', zorder=7, **M)
    a2.set_xlim(-0.05, 3.55); a2.set_ylim(-0.33, 1.85); a2.set_aspect('equal'); a2.axis('off')
    J.letter(a2, 'b', x=0.0, y=1.0)
    hs = [Rectangle((0, 0), 1, 1, facecolor=FILL, edgecolor='none'), Rectangle((0, 0), 1, 1, facecolor=UNF, edgecolor='none'),
          Rectangle((0, 0), 1, 1, facecolor=OVR, edgecolor='none'),
          plt.Line2D([], [], color=J.INK, lw=0.7), plt.Line2D([], [], color=PATH_C, lw=0.7),
          plt.Line2D([], [], color='#2f4f78', lw=0.6, ls=(0, (4, 1.5)))]
    fig.legend(hs, ['Filled target', 'Unfilled target', 'Overspill', 'Slice outline', 'Print path',
                    'Deposited outline'], ncol=6, loc='lower center', bbox_to_anchor=(0.6, -0.02), handlelength=1.4, columnspacing=1.2)
    save(fig, 7)


RENDER = {7: bead_model, 8: generalization, 9: agreement, 10: toolpath_summary, 11: forest, 12: deposition_maps,
          13: complexity}

if __name__ == '__main__':
    J.apply()
    for n in FIGURES:
        RENDER[n]()
        print(f'Fig {n}', flush=True)
