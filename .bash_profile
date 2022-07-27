#!/usr/bin/env bash

if [ -f $HOME/.bashrc ]; then
        source $HOME/.bashrc
fi

/usr/bin/keychain --nogui $HOME/.ssh/id_rsa
source $HOME/.keychain/$HOSTNAME-sh

for file in ~/.bashrc.d/*.bashrc;
do
        source "$file"
done
