#!/bin/bash
# Script to symlink Dotfiles to $home and prepare vim plugins
echo Cloing Vundle for VIM
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo Cloning TPM for Tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo Setting symlinks

MYDIR="$(dirname $(readlink -f $0))"
ln -nfs $MYDIR/.tmux.conf $HOME/.tmux.conf
ln -nfs $MYDIR/.bashrc $HOME/.bashrc
ln -nfs $MYDIR/.vimrc $HOME/.vimrc
ln -nfs $MYDIR/.gitconfig $HOME/.gitconfig

# If ~/.inputrc doesn't exist yet: First include the original /etc/inputrc
# so it won't get overriden
if [ ! -a $HOME/.inputrc ]; then echo '$include /etc/inputrc' > $HOME/.inputrc; fi

# Add shell-option to ~/.inputrc to enable case-insensitive tab completion
echo 'set completion-ignore-case On' >> $HOME/.inputrc
