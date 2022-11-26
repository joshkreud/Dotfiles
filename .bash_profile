#!/usr/bin/env bash

if [ -f $HOME/.bashrc ]; then
        source $HOME/.bashrc
fi

for file in $(find .rc.d -type f -o -type l -name "*.bash_profie");do
  source "$file"
done
