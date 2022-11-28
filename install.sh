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
        INSTALL_ZSH=true;shift;;
    -*|--*)
        echo "Unknown option $1"
        exit 1;;
    *)
        POSITIONAL_ARGS+=("$1");shift;;
    esac
done

#Detect Package manager
echo "==> Installing Git"
if $APT;then
    sudo apt install git
elif $PACMAN; then
    sudo pacman -S git --noconfirm
else
    echo "This script requires Pacman or Apt to work"
    exit 1
fi


echo "==> Setting symlinks"
MYDIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
RC_DIR=$MYDIR/rcfiles
ln -nfs $RC_DIR/.tmux.conf $HOME/.tmux.conf
ln -nfs $RC_DIR/.bashrc $HOME/.bashrc
ln -nfs $RC_DIR/.bash_profile $HOME/.bash_profile
ln -nfs $RC_DIR/.vimrc $HOME/.vimrc
ln -nfs $RC_DIR/.gitconfig $HOME/.gitconfig
ln -nfs $RC_DIR/.inputrc $HOME/.inputrc
ln -nfs $RC_DIR/fish/ $HOME/.config/fish
mkdir -p $HOME/.config/alacritty
ln -nfs $RC_DIR/alacritty.yml $HOME/.config/alacritty/alacritty.yml
ln -nfs  $RC_DIR/.vim/ $HOME/.vim


mkdir -p $HOME/.rc.d
chmod 700 $HOME/.rc.d
for file in $(find $RC_DIR/.rc.d -type f);do
    ln -nfs $file $HOME/.rc.d/$(basename -- $file)
done

TMUX_PLUG_DIR=$HOME/.tmux/plugins
mkdir -p $TMUX_PLUG_DIR
if [ ! "$(ls -A $TMUX_PLUG_DIR/tpm)" ]; then
    echo "==> Cloning Tmux TPM"
    git clone https://github.com/tmux-plugins/tpm $TMUX_PLUG_DIR/tpm
fi

echo "==> Installing Tools"
if $APT;then
    sudo apt install keychain socat tmux vim -y
elif $PACMAN; then
    sudo pacman -S keychain tmux vim socat --noconfirm
fi

if [ $INSTALL_ZSH == true ]; then
    echo "==> Installing ZSH and OhMyZSH"
    ln -nfs $RC_DIR/.zshrc $HOME/.zshrc
    if $APT;then
        sudo apt install zsh -y
    elif $PACMAN; then
        sudo pacman -S zsh --noconfirm
    fi
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi
