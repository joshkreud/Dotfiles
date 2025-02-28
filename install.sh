#!/bin/bash
# Script to symlink Dotfiles to $home and prepare vim plugins
set -e

POSITIONAL_ARGS=()
INSTALL_ZSH=false
INSTALL_NVIM=false

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $SCRIPT_DIR

git submodule update --init

command -v apt &> /dev/null && APT=true || APT=false
command -v pacman &> /dev/null && PACMAN=true || PACMAN=false
command -v brew &> /dev/null && BREW=true || BREW=false

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
    sudo apt update --fix-missing
    sudo apt -qq install git gcc -y
elif $PACMAN; then
    sudo pacman -S git gcc --noconfirm
elif $BREW; then
    brew install git gcc
else
    echo "This script requires Pacman or Apt to work"
    exit 1
fi

if [ -z $XDG_CONFIG_HOME ]; then
    XDG_CONFIG_HOME=$HOME/.config
fi
if [ ! -d $XDG_CONFIG_HOME ]; then
    mkdir -p $XDG_CONFIG_HOME
fi


echo "==> Setting symlinks"
RC_DIR=$SCRIPT_DIR/rcfiles
ln -nfs $RC_DIR/.tmux.conf $HOME/.tmux.conf
ln -nfs $RC_DIR/.bashrc $HOME/.bashrc
ln -nfs $RC_DIR/.bash_profile $HOME/.bash_profile
ln -nfs $RC_DIR/.vimrc $HOME/.vimrc
ln -nfs $RC_DIR/.gitconfig $HOME/.gitconfig
ln -nfs $RC_DIR/.inputrc $HOME/.inputrc
mkdir -p $XDG_CONFIG_HOME/alacritty
ln -nfs $RC_DIR/alacritty.yml $XDG_CONFIG_HOME/alacritty/alacritty.yml
ln -nfs  $RC_DIR/.vim $HOME/.vim

RCD_DIR=$HOME/.rc.d
mkdir -p $RCD_DIR
chmod 700 $RCD_DIR
for file in $(find $RC_DIR/.rc.d -type f);do
    ln -nfs $file $RCD_DIR/$(basename -- $file)
done

echo "==> Adding Custom Commands to Path"
CMD_DIR=$SCRIPT_DIR/commands
echo "export PATH=\$PATH:$CMD_DIR" > $RCD_DIR/josh_dotfiles_custom.rc

TMUX_PLUG_DIR=$HOME/.tmux/plugins
mkdir -p $TMUX_PLUG_DIR
if [ ! "$(ls -A $TMUX_PLUG_DIR/tpm)" ]; then
    echo "==> Cloning Tmux TPM"
    git clone https://github.com/tmux-plugins/tpm $TMUX_PLUG_DIR/tpm
fi

echo "==> Installing Tools"
if $APT;then
    sudo apt -qq install keychain socat tmux vim fd-find -y
elif $PACMAN; then
    sudo pacman -S keychain tmux vim socat fd --noconfirm
elif $BREW; then
    brew install keychain tmux vim socat fd
fi

if [ $INSTALL_ZSH == true ]; then
    echo "==> Installing ZSH and OhMyZSH"
    if $APT;then
        sudo apt -qq install zsh fzf -y
    elif $PACMAN; then
        sudo pacman -S zsh fzf --noconfirm
    elif $BREW; then
        brew install zsh fzf
    fi

    [ -z $ZSH ] && echo "===> Installing OhMyZsh" && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
    ln -nfs $RC_DIR/.zshrc $HOME/.zshrc

    if [[ $SHELL != */zsh ]]; then
        echo "Changing default shell to zsh"
        chsh -s $(which zsh)
    fi
fi

if [ $INSTALL_NVIM == true ]; then
    echo "==> Installing Nvim"
    ln -nfs $RC_DIR/nvchad $XDG_CONFIG_HOME/nvim
    ln -nfs $RC_DIR/nvchad_custom $XDG_CONFIG_HOME/nvim/lua/custom
    rm -rf $HOME/.local/share/nvim/

    if $APT;then
        sudo add-apt-repository ppa:neovim-ppa/unstable -y
        sudo apt -qq install neovim ripgrep fd-find unzip -y
    elif $PACMAN; then
        sudo pacman -S neovim ripgrep fd rust glow unzip --noconfirm
    elif $BREW; then
        brew install neovim ripgrep fd glow unzip
    fi
fi

echo "Done Installing JoshKreud Dotfiles"
