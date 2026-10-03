[ -r "$HOME/.config/shell/alias" ] && . "$HOME/.config/shell/alias"

# Export ZDOTDIR explicitly so every child of the session carries it.
export ZDOTDIR="$HOME/.config/zsh"

export XDG_RUNTIME_DIR="$(mkrundir)"

# Bus address shared with the OpenRC user dbus service.
[ -r /etc/user/conf.d/dbus ] && . /etc/user/conf.d/dbus

export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/var/lib/flatpak/exports/bin"
export PATH="$PATH:$HOME/.local/share/flatpak/exports/bin"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Android
export ANDROID_HOME="$HOME/.local/share/android"
export ANDROID_SDK_HOME="$HOME/.local/share/android"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"

# Golang
export GOPATH="$HOME/.local/share/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOBIN"

#export GIT_SSH=gitssh
export DOAS_ASKPASS=askpass
export PAGER="${PAGER:-bat}"
export EDITOR="${EDITOR:-nvim}"

. "$HOME/.cargo/env"
