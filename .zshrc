export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="crcandy"

HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode reminder  # just remind me to update when it's time

plugins=(git poetry git)

source $ZSH/oh-my-zsh.sh
