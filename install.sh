#!/bin/bash
# Script to symlink Dotfiles to $home and prepare vim plugins
set -e

POSITIONAL_ARGS=()
INSTALL_ZSH=false

command -v apt &> /dev/null && APT=true || APT=false
command -v pacman &> /dev/null && PACMAN=true || PACMAN=false

while [[ $# -gt 0 ]]; do
    case $1 in
    -z|--zsh)
        INSTALL_ZSH=true;shift;shift;;
    -*|--*)
        echo "Unknown option $1"
        exit 1;;
    *)
        POSITIONAL_ARGS+=("$1");shift;;
    esac
done

#Detect Package manager
if $APT;then
    sudo apt install git
elif $PACMAN; then
    sudo pacman -S git --noconfirm
else
    echo "This script requires Pacman or Apt to work"
    exit 1
fi

MYDIR="$(dirname $(readlink -f $0))"

echo "==> Setting symlinks"
ln -nfs $MYDIR/.tmux.conf $HOME/.tmux.conf
ln -nfs $MYDIR/.bashrc $HOME/.bashrc
ln -nfs $MYDIR/.bash_profile $HOME/.bash_profile
ln -nfs $MYDIR/.vimrc $HOME/.vimrc
ln -nfs $MYDIR/.gitconfig $HOME/.gitconfig
ln -nfs $MYDIR/.inputrc $HOME/.inputrc
ln -nfs $MYDIR/fish/ $HOME/.config/fish
mkdir -p $HOME/.config/alacritty
ln -nfs $MYDIR/alacritty.yml $HOME/.config/alacritty/alacritty.yml
ln -nfs  $MYDIR/.vim/ $HOME/.vim


mkdir -p $HOME/.rc.d
chmod 700 $HOME/.rc.d
for file in $(find $MYDIR/.rc.d -type f);do
    ln -nfs $file $HOME/.rc.d/$(basename -- $file)
done

TMUX_PLUG_DIR=$HOME/.tmux/plugins
mkdir -p $TMUX_PLUG_DIR
if [ ! "$(ls -A $TMUX_PLUG_DIR/tpm)" ]; then
    echo "==> Cloning Tmux TPM"
    git clone https://github.com/tmux-plugins/tpm $TMUX_PLUG_DIR/tpm
fi

echo "Installing Tools:"
if $APT;then
    sudo apt install keychain socat tmux vim -y
elif $PACMAN; then
    sudo pacman -S keychain tmux vim socat --noconfirm
fi

if [ $INSTALL_ZSH == true ]; then
    echo "==> Installing ZSH and OhMyZSH"
    ln -nfs $MYDIR/.zshrc $HOME/.zshrc
    if $APT;then
        sudo apt install zsh -y
    elif $PACMAN; then
        sudo pacman -S zsh --noconfirm
    fi
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
