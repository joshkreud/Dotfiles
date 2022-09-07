#!/bin/bash
# Script to symlink Dotfiles to $home and prepare vim plugins

echo Setting symlinks
MYDIR="$(dirname $(readlink -f $0))"
ln -nfs $MYDIR/.tmux.conf $HOME/.tmux.conf
ln -nfs $MYDIR/.bashrc $HOME/.bashrc
ln -nfs $MYDIR/.bash_profile $HOME/.bash_profile
ln -nfs $MYDIR/.vimrc $HOME/.vimrc
ln -nfs $MYDIR/.gitconfig $HOME/.gitconfig
ln -nfs $MYDIR/.inputrc $HOME/.inputrc
ln -nfs $MYDIR/fish/ $HOME/.config/fish

cp -r $MYDIR/.vim/ $HOME/

mkdir -p ~/.tmux/plugins
mkdir -p ~/.bashrc.d
chmod 700 ~/.bashrc.d

echo Cloning TPM for Tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "done installing dotfiles"

echo "Installing Tools:"
sudo apt install keychain socat git tmux vim -y
