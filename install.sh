#!/bin/bash
# Script to symlink Dotfiles to $home and prepare vim plugins

echo Setting symlinks
MYDIR="$(dirname $(readlink -f $0))"
ln -nfs $MYDIR/.tmux.conf $HOME/.tmux.conf
ln -nfs $MYDIR/.bashrc $HOME/.bashrc
ln -nfs $MYDIR/.vimrc $HOME/.vimrc
ln -nfs $MYDIR/.gitconfig $HOME/.gitconfig
ln -nfs $MYDIR/.inputrc $HOME/.inputrc

cp -r $MYDIR/.vim/ $HOME/.vim/

mkdir -p ~/.tmux/plugins
echo Cloning TPM for Tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
