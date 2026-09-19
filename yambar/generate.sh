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

# Colorscheme: chroma (dark)
#   base00 000000  base01 0a0a0a  base02 1e1e1e  base03 434343
#   base04 858585  base05 b2b2b2  base06 cfcfcf  base07 ffffff
#   base08 ca6789  base09 da8472  base0A eab532  base0B 6e9a5d
#   base0C 59aa90  base0D 088eaf  base0E 6f5fc3  base0F a47fc6
C_BG=000000ff        # base00 bg
C_SURFACE=0a0a0aff   # base01 surface
C_SEL=1e1e1eff       # base02 selection
C_MUTED=434343ff     # base03 muted (inactive tag / separator)
C_FG2=858585ff       # base04 fg-secondary
C_FG=b2b2b2ff        # base05 fg
C_FGHI=cfcfcfff      # base06 fg-highlight
C_FGMAX=ffffffff     # base07 fg-max (occupied)
C_RED=ca6789ff       # base08 urgent
C_ORANGE=da8472ff    # base09
C_YELLOW=eab532ff    # base0A accent
C_GREEN=6e9a5dff     # base0B date
C_CYAN=59aa90ff      # base0C time
C_BLUE=088eafff      # base0D updates
C_VIOLET=6f5fc3ff    # base0E
C_MAGENTA=a47fc6ff   # base0F memory
C_ACCENT=$C_YELLOW

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
