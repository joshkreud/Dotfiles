#!/bin/bash
WIN_PATH=$(wslpath "$(wslvar USERPROFILE)")
cp -r ${WIN_PATH}/.ssh ~
chmod 600 ~/.ssh/id_rsa
