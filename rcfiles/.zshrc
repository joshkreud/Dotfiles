set +x

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zmodload zsh/zprof
fi

for file in $(find $HOME/.rc.d \( -type f -o -type l \) \( -name "*.rc" -o -name "*.zshrc" \) | sort); do
  # Skip group/world-writable files (tamper guard)
  if [ -f "$file" ] && [ -O "$file" ]; then
    # Follow symlinks so we validate the target file mode, not link metadata.
    perms=$(stat -L -f '%Lp' "$file" 2>/dev/null || stat -L -c '%a' "$file" 2>/dev/null || stat -f '%Lp' "$file" 2>/dev/null || stat -c '%a' "$file" 2>/dev/null)
    # Parse mode as octal before masking group/other write bits.
    if [ -z "$perms" ] || [ $((8#$perms & 8#022)) -eq 0 ] 2>/dev/null; then
      source "$file"
    fi
  fi
done

# Make Zsh completion case-insensitive (e.g., `cd Doc<Tab>` matches `Documents`).
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{A-Z}={a-z}'

eval "$(starship init zsh)"
unsetopt autocd

prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)$USER"
  fi
}

export NVM_DIR="$HOME/.nvm"

# NVM is expensive to initialize, so wait until a Node command needs it.
load_nvm() {
  unset -f nvm node npm npx corepack load_nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
}

nvm() { load_nvm; nvm "$@"; }
node() { load_nvm; node "$@"; }
npm() { load_nvm; npm "$@"; }
npx() { load_nvm; npx "$@"; }
corepack() { load_nvm; corepack "$@"; }

if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi
