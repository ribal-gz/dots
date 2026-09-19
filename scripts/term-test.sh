#!/bin/sh

reset() { printf '\033[0m'; }
header() { printf '\n\033[1m== %s ==\033[0m\n' "$1"; }

palette() {
	printf '\033[1mANSI palette (regular 0-7)\033[0m\n'
	i=0
	while [ "$i" -le 7 ]; do
		printf '\033[48;5;%dm   \033[0m' "$i"
		i=$((i + 1))
	done
	printf '\n\033[1mANSI palette (bright 8-15)\033[0m\n'
	i=8
	while [ "$i" -le 15 ]; do
		printf '\033[48;5;%dm   \033[0m' "$i"
		i=$((i + 1))
	done
	printf '\n'
	i=0
	while [ "$i" -le 15 ]; do
		printf '\033[38;5;%dm%3d\033[0m ' "$i" "$i"
		i=$((i + 1))
		if [ $((i % 8)) -eq 0 ]; then printf '\n'; fi
	done
}

gradient() {
	printf '\033[1m256-color palette (16-255)\033[0m\n'
	i=16
	while [ "$i" -le 255 ]; do
		printf '\033[48;5;%dm ' "$i"
		i=$((i + 1))
		if [ $((i % 36)) -eq 0 ]; then
			reset
			printf '\n'
		fi
	done
	reset
	printf '\n'
}

truecolor() {
	printf '\033[1mscheme palette (truecolor)\033[0m\n'
	while read -r name r g b; do
		printf '\033[38;2;%s;%s;%sm' "$r" "$g" "$b"
		printf '%-7s' "$name"
		printf '\033[48;2;%s;%s;%sm   \033[0m ' "$r" "$g" "$b"
		printf '\033[38;2;%s;%s;%sm%s\033[0m\n' "$r" "$g" "$b" "$name"
	done <<'EOF'
base00 0 0 0
base01 10 10 10
base02 30 30 30
base03 67 67 67
base04 133 133 133
base05 178 178 178
base06 207 207 207
base07 255 255 255
base08 202 103 137
base09 218 132 114
base0A 234 181 50
base0B 110 154 93
base0C 89 170 144
base0D 8 142 175
base0E 111 95 195
base0F 164 127 198
EOF
}

attributes() {
	printf '\033[1mtext attributes\033[0m\n'
	sample='The quick brown fox jumps over the lazy dog 0123456789'
	attr() {
		printf '%-22s' "$1"
		printf '\033[%sm%s' "$2" "$sample"
		reset
		printf '\n'
	}
	attr 'regular'            '0'
	attr 'bold'               '1'
	attr 'dim/faint'          '2'
	attr 'italic'             '3'
	attr 'underline'          '4'
	attr 'blink'              '5'
	attr 'reverse'            '7'
	attr 'hidden'             '8'
	attr 'strikethrough'      '9'
	attr 'bold+italic'        '1;3'
	attr 'bold+underline'     '1;4'
	attr 'italic+underline'   '3;4'
	attr 'bold+italic+ul'     '1;3;4'
	attr 'underline+strike'   '4;9'
	attr 'red'                '31'
	attr 'bold red'           '1;31'
	attr 'underline red'      '4;31'
	attr 'strikethrough red'  '9;31'
	attr 'reverse red'        '7;31'
}

underline_styles() {
	printf '\033[1munderline styles\033[0m\n'
	i=1
	for name in single double curly dotted dashed; do
		printf '%-10s' "$name"
		printf '\033[4:%dm%s\033[0m\n' "$i" "underlined text sample"
		i=$((i + 1))
	done
}

fonts() {
	printf '\033[1mfont variants\033[0m\n'
	text='ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz 0123456789'
	printf '%-14s' regular;    printf '\033[0m%s\033[0m\n' "$text"
	printf '%-14s' bold;       printf '\033[1m%s\033[0m\n' "$text"
	printf '%-14s' italic;     printf '\033[3m%s\033[0m\n' "$text"
	printf '%-14s' bolditalic; printf '\033[1;3m%s\033[0m\n' "$text"
	printf '\n'
	printf '%-14s' 'ligatures'; printf '\033[0m-> => != >= <= == ++ -- --> <-> ::  ~= ~=\033[0m\n'
	printf '%-14s' 'box drawing'; printf '\033[0m+-+ |  +--+  ( ) [ ] { }  \033[0m\n'
}

icons() {
	printf '\033[1mnerd font icons\033[0m\n'
	icons='                   '
	legend='  E0B0  E0B1  E0B2  E0B3  E0A0  E0A1  E0A2  E702  F07B  F015  F021  F023  F00C  F00D  F013  F0C5  F121  E795  F17C  F1C0'
	printf '\033[0m%s\033[0m\n' "$icons"
	printf '\033[2m%s\033[0m\n' "$legend"
	printf '\n'
	printf '\033[1memoji\033[0m\n'
	printf '\033[0m😀 🚀 💩 ✅ ❌ 🔥 ✨ 💻 🖱 ⌨ 📁 📄 💾 🔍 🔧 🔒\033[0m\n'
	printf '\n'
	printf '\033[1mpowerline prompt\033[0m\n'
	printf '\033[48;5;235m\033[38;5;250m user@host \033[48;5;60m\033[38;5;235m\033[48;5;60m\033[38;5;255m ~/projects \033[49m\033[38;5;60m\033[0m  main\n'
}

selection() {
	printf '\033[1mselection / highlight\033[0m\n'
	printf 'dark   '
	printf '\033[48;2;30;30;30m\033[38;2;255;255;255m selected text sample \033[0m\n'
	printf 'light  '
	printf '\033[48;2;178;178;178m\033[38;2;0;0;0m selected text sample \033[0m\n'
	printf 'accent '
	printf '\033[48;2;234;181;50m\033[38;2;0;0;0m dark accent base0A \033[0m '
	printf '\033[48;2;8;142;175m\033[38;2;255;255;255m light accent base0D \033[0m\n'
}

header 'colors'
palette
gradient
truecolor
header 'text'
attributes
underline_styles
header 'fonts & glyphs'
fonts
icons
header 'selection'
selection
reset
printf '\n'
