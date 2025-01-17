if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zmodload zsh/zprof
fi

export ZSH="$HOME/.oh-my-zsh"

autoload -Uz compinit
# Only check completion dump once per day
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null) ]; then
  compinit
else
  compinit -C
fi

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="refined"

HYPHEN_INSENSITIVE="true"

DISABLE_UPDATE_PROMPT=true
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

plugins=(git safe-paste fzf colored-man-pages)

unset zle_bracketed_paste

source $ZSH/oh-my-zsh.sh

for file in $(find $HOME/.rc.d \( -type f -o -type l \) \( -name "*.rc" -o -name "*.zshrc" \)); do
  source "$file"
done

unsetopt autocd

prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi
