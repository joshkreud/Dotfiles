#!/bin/bash
# Script to symlink Dotfiles to $home and prepare vim plugins

POSITIONAL_ARGS=()
INSTALL_SSH=false

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
if [ ! "$(ls -A $DIR)" ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
echo "done installing dotfiles"

if command -v apt &> /dev/null; then
    echo "Installing Tools for Debian based systems:"
    sudo apt install keychain socat git tmux vim -y
    exit
fi

if [ $INSTALL_SSH == true ]; then
    ln -nfs $MYDIR/.zshrc $HOME/.zshrc
    if command -v apt &> /dev/null; then
        sudo apt install zsh -y
        exit
    fi
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi
