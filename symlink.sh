#!/bin/bash
# Script to symlink Dotfiles to $home and prepare vim plugins
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
ln -nfs $PWD/.tmux.conf $HOME/.tmux.conf
ln -nfs $PWD/.bashrc $HOME/.bashrc
ln -nfs $PWD/.vimrc $HOME/.vimrc
ln -nfs $PWD/.gitconfig $HOME/.gitconfig
