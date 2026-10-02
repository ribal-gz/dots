# Color palette

A 24-color colorscheme designed around a predominantly monochromatic UI.

The palette is divided into:
- base00-base07: monochromatic UI colors
- base08-base0F: semantic colors
- base10-base17: semantic colors (bright)

## Monochromatic UI colors

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

## Semantic colors

Semantic colros are only used when they convey information.
They are not used for general UI, syntax highlighting or decorations.

The only semantic color used as a general UI color is the **accent**.

- **base08**: oklch(54.5%  .180 359);    // #bc336e (red)    - Error, destructive
- **base09**: oklch(53.0%  .136  52);    // #a75003 (orange)
- **base0A**: oklch(56.0%  .117 104);    // #807704 (yellow) - Warning
- **base0B**: oklch(50.5%  .151 137);    // #367702 (green)  - Success
- **base0C**: oklch(56.0%  .096 189);    // #068680 (cyan)   - Info
- **base0D**: oklch(51.5%  .12  242);    // #036ea6 (blue)   - Light accent
- **base0E**: oklch(53.0%  .18  274);    // #4f5cd1 (violet) - Link, navigation
- **base0F**: oklch(54.5%  .18  327);    // #a340a6 (magenta) - Special, deprecated

### bright
- **base10**: oklch(82.0%  .11  359);    // #ffa6c2 (red)     - Error, destructive
- **base11**: oklch(82.0%  .113  52);    // #ffaf7f (orange)  - Dark accent
- **base12**: oklch(82.0%  .14  104);    // #d3c850 (yellow)  - Warning
- **base13**: oklch(82.0%  .14  137);    // #99d97c (green)   - Success
- **base14**: oklch(82.0%  .14  189);    // #15e1d7 (cyan)    - Info
- **base15**: oklch(82.0%  .098 242);    // #89ccfe (blue)
- **base16**: oklch(82.0%  .089 274);    // #b2c0fe (violet)  - Link, navigation
- **base17**: oklch(82.0%  .140 327);    // #f3a3f4 (magenta) - Special, deprecated

## Dark variant

The dark mode assings semantic colors from base10 to base17 range

- bg:           base00
- surface:      base01
- selection:    base02

- fg:           base05
- fg-secondary: base04
- fg-highlight: base06
- fg-max:       base07
- muted:        base03

- accent:       base11

## Light variant

The light mode assings semantic colors from base08 to base0F range

- bg:           base07
- surface:      base06
- selection:    base05

- fg:           base02
- fg-secondary: base02
- fg-highlight: base01
- fg-max:       base00
- muted:        base04

- accent:       base0D

## Ansi colors

### Normal
-  0: base00
-  1: base08
-  2: base0B
-  3: base0A
-  4: base0D
-  5: base0E
-  6: base0C
-  7: base05

### Bright
-  8: base03
-  9: base10
- 10: base13
- 11: base12
- 12: base15
- 13: base16
- 14: base14
- 15: base07
