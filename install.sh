#!/bin/bash
# Script to symlink Dotfiles to $home and prepare vim plugins

POSITIONAL_ARGS=()
INSTALL_SSH=false

command -v apt &> /dev/null && APT=true || APT=false
command -v pacman &> /dev/null && PACMAN=true || PACMAN=false

while [[ $# -gt 0 ]]; do
    case $1 in
    -z|--zsh)
        INSTALL_SSH=true;shift;shift;;
    -*|--*)
        echo "Unknown option $1"
        exit 1;;
    *)
        POSITIONAL_ARGS+=("$1");shift;;
    esac
done

if $APT;then
    sudo apt install git
elif $PACMAN; then
    sudo pacman -S git --noconfirm
fi


echo Setting symlinks
MYDIR="$(dirname $(readlink -f $0))"
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

mkdir -p ~/.tmux/plugins
mkdir -p ~/.bashrc.d
chmod 700 ~/.bashrc.d

echo Cloning TPM for Tmux
if [ ! "$(ls -A $DIR)" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
echo "done installing dotfiles"

echo "Installing Tools:"
if $APT;then
    sudo apt install keychain socat tmux vim -y
elif $PACMAN; then
    sudo pacman -S keychain tmux vim socat --noconfirm
fi

if [ $INSTALL_SSH == true ]; then
    ln -nfs $MYDIR/.zshrc $HOME/.zshrc
    if $APT;then
        sudo apt install zsh -y
    elif $PACMAN; then
        sudo pacman -S zsh --noconfirm
    fi
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
