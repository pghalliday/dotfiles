#!/bin/bash
BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
VUNDLE_INSTALL_DIR=~/.vim/bundle/Vundle.vim
if ! [ -d "$VUNDLE_INSTALL_DIR" ]
then
	git clone https://github.com/gmarik/Vundle.vim.git $VUNDLE_INSTALL_DIR
fi
ln -fs $BASEDIR/.vimrc ~/
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/undo
vim +PluginInstall +qall
