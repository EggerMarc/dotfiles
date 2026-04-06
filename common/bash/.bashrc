#
# ~/.bashrc - OMArchy style
#

[[ $- != *i* ]] && return

# OMArchy
export OMARCHY_PATH="$HOME/.local/share/omarchy"
export PATH="$OMARCHY_PATH/bin:$HOME/.local/bin:$PATH"

# Aliases
alias ls='eza -la --icons'
alias cat='bat --paging=never'
alias grep='rg'
alias cd='z'
alias vim='nvim'

# Shell
eval "$(starship init bash)"
eval "$(zoxide init bash)"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Local env
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"

# Google Cloud SDK
[ -f "$HOME/google-cloud-sdk/path.bash.inc" ] && . "$HOME/google-cloud-sdk/path.bash.inc"
[ -f "$HOME/google-cloud-sdk/completion.bash.inc" ] && . "$HOME/google-cloud-sdk/completion.bash.inc"

fastfetch
