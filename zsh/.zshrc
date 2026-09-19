# Interactive shell configuration.

# ---------------------------------------------------------------------------
# Completion
# ---------------------------------------------------------------------------
# zsh-completions provides extra completion definitions.
fpath=("/usr/share/zsh/plugins/zsh-completions/src" $fpath)

autoload -Uz compinit
mkdir -p "$XDG_CACHE_HOME/zsh"
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump"

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ---------------------------------------------------------------------------
# Aliases
# ---------------------------------------------------------------------------
alias e='$EDITOR'
alias ll='ls -lh'
alias la='ls -lah'

# ---------------------------------------------------------------------------
# Prompt
# ---------------------------------------------------------------------------
export STARSHIP_CONFIG="${XDG_CONFIG_HOME}/starship.toml"
eval "$(starship init zsh)"

# ---------------------------------------------------------------------------
# Terminal integration (foot)
# ---------------------------------------------------------------------------
# OSC 7: report the working directory. foot uses it to open new terminals
# (Control+Shift+n) in the current directory.
function osc7-pwd() {
  emulate -L zsh
  setopt extendedglob
  local LC_ALL=C
  printf '\e]7;file://%s%s\e\\' "$HOST" \
    "${PWD//(#m)([^@-Za-z&-;_~])/%${(l:2::0:)$(([##16]#MATCH))}}"
}

function chpwd-osc7-pwd() {
  (( ZSH_SUBSHELL )) || osc7-pwd
}

# OSC 133: prompt marks. Enable jump-between-prompts and
# pipe-command-output (Control+Shift+n family) in foot.
function preexec-osc133() {
  print -n '\e]133;C\e\\'
}

function precmd-osc133() {
  if ! builtin zle; then
    print -n '\e]133;D\e\\'
  fi
  print -n '\e]133;A\e\\'
}

autoload -Uz add-zsh-hook
add-zsh-hook -Uz chpwd chpwd-osc7-pwd
add-zsh-hook -Uz preexec preexec-osc133
add-zsh-hook -Uz precmd precmd-osc133
osc7-pwd

# ---------------------------------------------------------------------------
# Plugins (order matters: syntax-highlighting must be sourced last)
# ---------------------------------------------------------------------------
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# fzf key bindings and fuzzy completion
source /usr/share/zsh/plugins/fzf/key-bindings.zsh
source /usr/share/zsh/plugins/fzf/completion.zsh

# ---------------------------------------------------------------------------
# zoxide (smarter cd)
# ---------------------------------------------------------------------------
# Print the matched directory before navigating to it.
export _ZO_ECHO=1
eval "$(zoxide init zsh)"

# ---------------------------------------------------------------------------
# Vi mode (zsh-vi-mode)
# ---------------------------------------------------------------------------
# Configured before sourcing; the plugin calls zvm_config automatically.
function zvm_config() {
  # Cursor shape per mode (terminal must support DECSCUSR; foot does).
  ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
  ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
  ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK

  # System clipboard (Wayland).
  ZVM_SYSTEM_CLIPBOARD_ENABLED=true
  ZVM_CLIPBOARD_COPY_CMD='wl-copy'
  ZVM_CLIPBOARD_PASTE_CMD='wl-paste --no-newline'

  # Selection highlight (chroma: base02 bg, base07 fg).
  ZVM_VI_HIGHLIGHT_BACKGROUND='#1e1e1e'
  ZVM_VI_HIGHLIGHT_FOREGROUND='#ffffff'
  ZVM_VI_HIGHLIGHT_EXTRASTYLE='default'
}

# zsh-vi-mode overwrites keybindings on init; restore fzf and atuin
# afterwards, so atuin's Ctrl-R wins over fzf's in vi mode.
zvm_after_init_commands+=(
  'source /usr/share/zsh/plugins/fzf/key-bindings.zsh'
  'source /usr/share/zsh/plugins/fzf/completion.zsh'
  'eval "$(atuin init zsh)"'
)

source "$ZDOTDIR/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"

# ---------------------------------------------------------------------------
# Atuin (shell history)
# ---------------------------------------------------------------------------
eval "$(atuin init zsh)"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
