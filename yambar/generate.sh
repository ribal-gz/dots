#!/bin/sh

# icons (Nerd Font codepoints)
TAG0=$(printf '\xEF\x84\xA0')  # 1: terminal (fa-terminal)
TAG1=$(printf '\xEF\x89\xA9')  # 2: browser (fa-firefox)
TAG2=$(printf '\xEF\x86\xB2')  # 3: work (fa-cube)
TAG3=$(printf '\xEF\x80\xAD')  # 4: pkm (fa-book)
TAG4=$(printf '\xEF\x81\xBB')  # 5: generic (fa-folder)
TAG5=$(printf '\xEF\x85\x9C')  # 6: generic (fa-file-text)
TAG6=$(printf '\xEF\x82\xAD')  # 7: generic (fa-wrench)
TAG7=$(printf '\xEF\x86\xB6')  # 8: gaming (fa-steam)
TAG8=$(printf '\xEF\x82\x86')  # 9: chats (fa-comments)

UPDATES=$(printf '\xEF\x80\x99')  # updates (fa-download)
MEMORY=$(printf '\xEF\x8B\x9B')   # memory (fa-microchip)
DATE=$(printf '\xEF\x81\xB3')     # date (fa-calendar)
TIME=$(printf '\xEF\x80\x97')     # time (fa-clock-o)

ICONS="$TAG0 $TAG1 $TAG2 $TAG3 $TAG4 $TAG5 $TAG6 $TAG7 $TAG8"
TAG_NUMS="1 2 3 4 5 6 7 8 9"

# Colorscheme: chroma (dark, docs/colorscheme.md)
#   base00 000000  base01 0a0a0a  base02 1e1e1e  base03 434343
#   base04 858585  base05 b2b2b2  base06 cfcfcf  base07 ffffff
#   base08 bc336e  base09 a75003  base0A 807704  base0B 367702
#   base0C 068680  base0D 036ea6  base0E 4f5cd1  base0F a340a6
#   base10 ffa6c2  base11 ffaf7f  base12 d3c850  base13 99d97c
#   base14 15e1d7  base15 89ccfe  base16 b2c0fe  base17 f3a3f4
C_BG=000000ff        # base00 bg
C_SURFACE=0a0a0aff   # base01 surface
C_SEL=1e1e1eff       # base02 selection
C_MUTED=434343ff     # base03 muted (inactive tag / separator)
C_FG2=858585ff       # base04 fg-secondary
C_FG=b2b2b2ff        # base05 fg
C_FGHI=cfcfcfff      # base06 fg-highlight
C_FGMAX=ffffffff     # base07 fg-max (occupied)
C_RED=ffa6c2ff       # base10 red-error (dark uses bright)
C_ORANGE=ffaf7fff    # base11 dark accent
C_YELLOW=d3c850ff    # base12 yellow-warning
C_GREEN=99d97cff     # base13 green-success (date)
C_CYAN=15e1d7ff      # base14 cyan-info (time)
C_BLUE=89ccfeff      # base15 blue (updates)
C_VIOLET=b2c0feff     # base16 violet
C_MAGENTA=f3a3f4ff   # base17 magenta (memory)
C_ACCENT=$C_ORANGE

gen_file() {
    MONITOR=$1 FILE=$2 PXSIZE=$3 HEIGHT=$4 MARGIN=$5 SPACING=$6

    # Build river script content for all 9 tags
    TAG_YML=""
    set -- $ICONS
    for tn in $TAG_NUMS; do
        icon=$1
        shift
        TAG_YML="$TAG_YML
        - map:
            default:
              string: {text: \"$icon\", margin: $MARGIN, foreground: $C_MUTED, on-click: \"mmsg dispatch view,$tn\"}
            conditions:
              \"show${tn} && active${tn}\":
                string: {text: \"$icon\", margin: $MARGIN, foreground: $C_ACCENT, on-click: \"mmsg dispatch view,$tn\"}
              \"show${tn} && urgent${tn}\":
                string: {text: \"$icon\", margin: $MARGIN, foreground: $C_RED, on-click: \"mmsg dispatch view,$tn\"}
              show${tn}:
                string: {text: \"$icon\", margin: $MARGIN, foreground: $C_FGMAX, on-click: \"mmsg dispatch view,$tn\"}"
    done

    cat > "$FILE" << YAMLEOF
.left: &left
  - script:
      path: ~/.config/yambar/scripts/workspaces.sh
      args: ['$MONITOR']
      content:$TAG_YML

.right: &right
  - script:
      path: ~/.config/yambar/scripts/updates.sh
      poll-interval: 60000
      content:
        string:
          text: "$UPDATES {output}"
          foreground: "$C_BLUE"
          on-click: "footclient apk-menu"
  - label:
      content: {string: {text: " | ", foreground: "$C_MUTED"}}
  - script:
      path: ~/.config/yambar/scripts/memory.sh
      poll-interval: 30000
      content:
        string:
          text: "$MEMORY {output}"
          foreground: "$C_MAGENTA"
          on-click: "footclient htop"
  - label:
      content: {string: {text: " | ", foreground: "$C_MUTED"}}
  - clock:
      date-format: "%b %d (%a)"
      content:
        string:
          text: "$DATE {date}"
          foreground: "$C_GREEN"
  - label:
      content: {string: {text: " | ", foreground: "$C_MUTED"}}
  - clock:
      time-format: "%I:%M%p"
      content:
        string:
          text: "$TIME {time}"
          foreground: "$C_CYAN"

.bar: &bar
  location: top
  layer: top
  height: $HEIGHT
  background: $C_BG
  foreground: $C_FG
  font: "DejaVuSansM Nerd Font Mono:pixelsize=$PXSIZE"
  spacing: $SPACING

  left: *left
  right: *right

bar:
  <<: *bar
  monitor: '$MONITOR'
YAMLEOF
}

gen_common() {
    FILE=$1
    TAG_YML=""
    set -- $ICONS
    for tn in $TAG_NUMS; do
        icon=$1
        shift
        TAG_YML="$TAG_YML
        - map:
            default:
              string: {text: \"$icon\", margin: 4, foreground: $C_MUTED, on-click: \"mmsg dispatch view,$tn\"}
            conditions:
              \"show${tn} && active${tn}\":
                string: {text: \"$icon\", margin: 4, foreground: $C_ACCENT, on-click: \"mmsg dispatch view,$tn\"}
              \"show${tn} && urgent${tn}\":
                string: {text: \"$icon\", margin: 4, foreground: $C_RED, on-click: \"mmsg dispatch view,$tn\"}
              show${tn}:
                string: {text: \"$icon\", margin: 4, foreground: $C_FGMAX, on-click: \"mmsg dispatch view,$tn\"}"
    done

    cat > "$FILE" << YAMLEOF
.left: &left
  - script:
      path: ~/.config/yambar/scripts/workspaces.sh
      content:$TAG_YML

.right: &right
  - script:
      path: ~/.config/yambar/scripts/updates.sh
      poll-interval: 60000
      content:
        string:
          text: "$UPDATES {output}"
          foreground: "$C_BLUE"
          on-click: "footclient apk-menu"
  - label:
      content: {string: {text: " | ", foreground: "$C_MUTED"}}
  - script:
      path: ~/.config/yambar/scripts/memory.sh
      poll-interval: 30000
      content:
        string:
          text: "$MEMORY {output}"
          foreground: "$C_MAGENTA"
          on-click: "footclient htop"
  - label:
      content: {string: {text: " | ", foreground: "$C_MUTED"}}
  - clock:
      date-format: "%b %d (%a)"
      content:
        string:
          text: "$DATE {date}"
          foreground: "$C_GREEN"
  - label:
      content: {string: {text: " | ", foreground: "$C_MUTED"}}
  - clock:
      time-format: "%I:%M%p"
      content:
        string:
          text: "$TIME {time}"
          foreground: "$C_CYAN"

.bar: &bar
  location: top
  layer: top
  height: 20
  background: $C_BG
  foreground: $C_FG
  font: "DejaVuSansM Nerd Font Mono:pixelsize=14"
  spacing: 4

  left: *left
  right: *right
YAMLEOF
}

gen_common   "/home/ribal/.config/yambar/common.yml"
gen_file "DP-1"     "/home/ribal/.config/yambar/dp-1.yml"     16 20 4 4
gen_file "HDMI-A-1" "/home/ribal/.config/yambar/hdmi-a-1.yml" 24 30 8 6
gen_file "HDMI-A-2" "/home/ribal/.config/yambar/hdmi-a-2.yml" 24 30 8 6
