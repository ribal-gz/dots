# Environment for all zsh invocations (login, interactive, scripts).

# Disable Alpine's automatic plugin loading so we control the source order
# ourselves in .zshrc (compinit -> autosuggestions -> syntax-highlighting).
zsh_plugin_dirs=()

# XDG base directories
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# History file
HISTFILE="${XDG_DATA_HOME}/zsh/history"
