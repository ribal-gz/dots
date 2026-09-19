# Login shell profile.
#
# POSIX environment shared with other shells lives in ~/.profile. zsh only
# sources ~/.zprofile (not ~/.profile), so pull it in here.
[ -f "$HOME/.profile" ] && . "$HOME/.profile"
