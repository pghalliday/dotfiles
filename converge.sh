#!/bin/bash
BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)
VUNDLE_INSTALL_DIR=~/.vim/bundle/Vundle.vim
if ! [ -d "$VUNDLE_INSTALL_DIR" ]
then
	git clone https://github.com/gmarik/Vundle.vim.git $VUNDLE_INSTALL_DIR
fi
BASE16_SHELL_INSTALL_DIR=~/.config/base16-shell
if ! [ -d "$BASE16_SHELL_INSTALL_DIR" ]
then
	git clone https://github.com/chriskempson/base16-shell.git $BASE16_SHELL_INSTALL_DIR
  cat << 'EOF' >> ~/.bashrc

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
EOF
fi
ln -fs $BASEDIR/.vimrc ~/
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/undo
vim +PluginInstall +qall
