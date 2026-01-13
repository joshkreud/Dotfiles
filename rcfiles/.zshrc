set +x

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zmodload zsh/zprof
fi

autoload -Uz compinit
# Only check completion dump once per day
if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null) ]; then
  echo "Rebuilding completion dump file..."
  compinit
else
  compinit -C
fi


for file in $(find $HOME/.rc.d \( -type f -o -type l \) \( -name "*.rc" -o -name "*.zshrc" \)); do
  source "$file"
done

eval "$(starship init zsh)"
unsetopt autocd

prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}

export NVM_DIR="$HOME/.nvm"


load_nvm_and_unset() {
  unset -f nvm npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

nvm() {
  load_nvm_and_unset
  nvm "$@"
}

npm() {
  load_nvm_and_unset
  npm "$@"
}

npx() {
  load_nvm_and_unset
  npx "$@"
}

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/joshuakreuder/.cache/lm-studio/bin"
