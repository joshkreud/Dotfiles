#!/usr/bin/env bash

if [ -f $HOME/.bashrc ]; then
        source $HOME/.bashrc
fi

for file in $(find $HOME/.rc.d \( -type f -o -type l \) -name "*.bash_profile"); do
  # Skip group/world-writable files (tamper guard)
  if [ -f "$file" ] && [ -O "$file" ]; then
    perms=$(stat -f '%Lp' "$file" 2>/dev/null || stat -c '%a' "$file" 2>/dev/null)
    if [ -z "$perms" ] || [ $((perms & 022)) -eq 0 ] 2>/dev/null; then
      source "$file"
    fi
  fi
done
