#!/bin/bash
BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
VUNDLE_INSTALL_DIR=~/.vim/bundle/Vundle.vim
if ! [ -d "$VUNDLE_INSTALL_DIR" ]
then
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
ln -fs $BASEDIR/.vimrc ~/
vim +PluginInstall +qall
