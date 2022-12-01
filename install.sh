#!/bin/bash
# Script to symlink Dotfiles to $home and prepare vim plugins
set -e

POSITIONAL_ARGS=()
INSTALL_ZSH=false
INSTALL_NVIM=false

command -v apt &> /dev/null && APT=true || APT=false
command -v pacman &> /dev/null && PACMAN=true || PACMAN=false

while [[ $# -gt 0 ]]; do
    case $1 in
    -z|--zsh)
        INSTALL_ZSH=true;shift;;
    -n|--nvim)
        INSTALL_NVIM=true;shift;;
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
    sudo apt -qq install git
elif $PACMAN; then
    sudo pacman -S git --noconfirm
else
    echo "This script requires Pacman or Apt to work"
    exit 1
fi

if [ -z $XDG_CONFIG_HOME ]; then
    XDG_CONFIG_HOME=$HOME/.config
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
ln -nfs $RC_DIR/fish $XDG_CONFIG_HOME/fish
mkdir -p $XDG_CONFIG_HOME/alacritty
ln -nfs $RC_DIR/alacritty.yml $XDG_CONFIG_HOME/alacritty/alacritty.yml
ln -nfs  $RC_DIR/.vim $HOME/.vim


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
    sudo apt -qq install keychain socat tmux vim -y
elif $PACMAN; then
    sudo pacman -S keychain tmux vim socat --noconfirm
fi

if [ $INSTALL_ZSH == true ]; then
    echo "==> Installing ZSH and OhMyZSH"
    if $APT;then
        sudo apt -qq install zsh -y
    elif $PACMAN; then
        sudo pacman -S zsh --noconfirm
    fi

    [ -z $ZSH ] && echo "===> Installing OhMyZsh" && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    ln -nfs $RC_DIR/.zshrc $HOME/.zshrc

    POWERLEVEL_FOLDER=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    [ ! -d $POWERLEVEL_FOLDER ] && echo "===> Installing Powerlevel10k" && git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $POWERLEVEL_FOLDER
    ln -nfs $RC_DIR/.p10k.zsh $HOME/.p10k.zsh
fi

if [ $INSTALL_NVIM == true ]; then
    echo "==> Installing Nvim"
    ln -nfs $RC_DIR/nvim $XDG_CONFIG_HOME/nvim
    if $APT;then
        sudo apt -qq install neovim ripgrep fd-find -y
    elif $PACMAN; then
        sudo pacman -S neovim ripgrep fd --noconfirm
    fi
    PACKER_PATH=$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim
    if [ ! "$(ls -A $PACKER_PATH)" ]; then
        echo "===> Cloning Packer"
        git clone --depth 1 https://github.com/wbthomason/packer.nvim $PACKER_PATH
    fi
fi
