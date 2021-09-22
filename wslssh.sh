#!/bin/bash
WIN_PATH=$(wslpath "$(wslvar USERPROFILE)")
echo Copying .ssh from $WIN_PATH
cp -r ${WIN_PATH}/.ssh ~
chmod 600 ~/.ssh/id_rsa

PRIVKEYS=$(find ~/.ssh -name "*.pub" | sed -r -e "s~(.*)\.pub~\1~g")

for KEY in $PRIVKEYS
do
    echo Fixing permissions on $KEY
    chmod 600 $KEY
done
