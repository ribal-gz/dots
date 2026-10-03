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
# History (native file; atuin keeps its own db in parallel for Ctrl-R)
# ---------------------------------------------------------------------------
HISTSIZE=100000
SAVEHIST=100000
setopt APPEND_HISTORY SHARE_HISTORY HIST_IGNORE_DUPS HIST_REDUCE_BLANKS

# ---------------------------------------------------------------------------
# Aliases
# ---------------------------------------------------------------------------
[ -f "$HOME/.config/shell/alias" ] && . "$HOME/.config/shell/alias"
alias reload="source ${ZDOTDIR}/.zshrc && rehash"

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
# fzf (fd backend: faster, respects .gitignore)
# ---------------------------------------------------------------------------
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

_fzf_compgen_path() {
  fd --hidden --follow --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude .git . "$1"
}

# ---------------------------------------------------------------------------
# Plugins (order matters: fzf-tab after compinit but before widget-wrapping
# plugins; syntax-highlighting must be sourced last)
# ---------------------------------------------------------------------------
# fzf-tab: fuzzy completion menu for normal Tab (** still opens the
# official fzf UI, handled by completion.zsh below).
source "$ZDOTDIR/plugins/fzf-tab/fzf-tab.plugin.zsh"

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

# zsh-vi-mode overwrites keybindings on init; re-apply afterwards.
# History belongs to atuin: fzf is unbound from ^R everywhere (it keeps
# its file/cd widgets), then atuin takes ^R in all keymaps.
zvm_after_init_commands+=(
  'source "$ZDOTDIR/plugins/fzf-tab/fzf-tab.plugin.zsh"'
  'source /usr/share/zsh/plugins/fzf/key-bindings.zsh'
  'source /usr/share/zsh/plugins/fzf/completion.zsh'
  'bindkey -r -M emacs "^R"'
  'bindkey -r -M viins "^R"'
  'bindkey -r -M vicmd "^R"'
  'eval "$(atuin init zsh --disable-up-arrow)"'
  'bindkey -M vicmd "^R" atuin-search-vicmd'
  'bindkey -r -M emacs "^T"'
  'bindkey -r -M viins "^T"'
  'bindkey -r -M vicmd "^T"'
  'bindkey -M emacs "^F" fzf-file-widget'
  'bindkey -M viins "^F" fzf-file-widget'
  'bindkey -M vicmd "^F" fzf-file-widget'
  'bindkey -r -M emacs "\ec"'
  'bindkey -r -M viins "\ec"'
  'bindkey -r -M vicmd "\ec"'
  'bindkey -M emacs "^D" fzf-cd-widget'
  'bindkey -M viins "^D" fzf-cd-widget'
  'bindkey -M vicmd "^D" fzf-cd-widget'
)

# `jk` escapes to normal mode (read before plugin init).
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

source "$ZDOTDIR/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"

# ---------------------------------------------------------------------------
# Atuin (Ctrl-R opens its TUI; Up-arrow stays fully native, no atuin UI)
# ---------------------------------------------------------------------------
eval "$(atuin init zsh --disable-up-arrow)"

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
