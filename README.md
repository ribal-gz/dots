# Dotfiles

## Colorscheme

A 16-color colorscheme designed around a predominantly monochromatic UI.

The palette is divided into:
- **base00-base07**: monochromatic UI colors
- **base08-base0F**: semantic colors

### Monochromatic UI colors

- **base00**: oklch(0%     0 0);    // #000000 - Darkest
- **base01**: oklch(14.6%  0 0);    // #0a0a0a - Secondary surface
- **base02**: oklch(23.6%  0 0);    // #1e1e1e - Selection, active element
- **base03**: oklch(38.2%  0 0);    // #434343 - Comments, muted, invisible, separators
- **base04**: oklch(61.8%  0 0);    // #858585 - Secondary foreground
- **base05**: oklch(76.4%  0 0);    // #b2b2b2 - Main foreground
- **base06**: oklch(85.4%  0 0);    // #cfcfcf - Foreground highlight
- **base07**: oklch(100%   0 0);    // #ffffff - Lightest, maximum contrast

`base00` and `base07` represent the extremes of the monochromatic scale and
should generally be reserved for backgrounds and high-contrast elements.

### Semantic colors
- **base08**: oklch(64% .13 0);     // #ca6789 (red)     - Error, destructive
- **base09**: oklch(70% .11 32.5);  // #da8472 (orange)  - Warning
- **base0A**: oklch(80% .15 85);    // #eab532 (yellow)  - Dark accent
- **base0B**: oklch(64% .10 137.5); // #6e9a5d (green)   - Success
- **base0C**: oklch(68% .09 170);   // #59aa90 (cyan)    - Info
- **base0D**: oklch(60% .11 222.5); // #088eaf (blue)    - Light accent
- **base0E**: oklch(55% .15 287.5); // #6f5fc3 (violet)  - Link, navigation
- **base0F**: oklch(66% .11 307.5); // #a47fc6 (magenta) - Special, deprecated

Semantic colors are only used when they convey information.
They are not used for general UI, syntax highlighting or decorations.

The only semantic color used as a general UI color is the **accent**:

- `base0A` in Dark
- `base0D` in Light

All other semantic colors retain their meaning across both variants.

### Dark variant

Dark mode uses the darkest values as the structural foundation.

- **bg**:           base00
- **surface**:      base01
- **selection**:    base02

- **fg**:           base05
- **fg-secondary**: base04
- **fg-highlight**: base06
- **fg-max**:       base07
- **muted**:        base03

- **accent**:       base0A

### Light variant

Light mode inverts the monochromatic structure while preserving the same
semantic hierarchy.

- **bg**:           base07
- **surface**:      base06
- **selection**:    base05

- **fg**:           base02
- **fg-secondary**: base03
- **fg-highlight**: base01
- **fg-max**:       base00
- **muted:      base04

- **accent**:       base0D

