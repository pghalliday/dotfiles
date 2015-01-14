#!/bin/bash
BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)

rm -rf ~/.dotfiles
mkdir -p ~/.dotfiles

# enable sourcing additional bashrc config files from ~/.dotfiles/bashrc.d
if ! grep -q .dotfiles/bashrc.d ~/.bashrc; then
  cat << 'EOF' >> ~/.bashrc

for file in $HOME/.dotfiles/bashrc.d/*
do . $file
done
EOF
fi
cp -r $BASEDIR/bashrc.d ~/.dotfiles/

# enable sourcing additional bash_aliases config files from ~/.dotfiles/bash_aliases.d
if ! grep -q .dotfiles/bash_aliases.d ~/.bash_aliases; then
  cat << 'EOF' >> ~/.bash_aliases

for file in $HOME/.dotfiles/bash_aliases.d/*
do . $file
done
EOF
fi
cp -r $BASEDIR/bash_aliases.d ~/.dotfiles/

# base16 theme configuration (also see bashrc.d/base16 and .vimrc)
BASE16_SHELL_INSTALL_DIR=~/.config/base16-shell
if ! [ -d "$BASE16_SHELL_INSTALL_DIR" ]
then
	git clone https://github.com/chriskempson/base16-shell.git $BASE16_SHELL_INSTALL_DIR
fi

# tmux configuration (also see bash_aliases.d/tmux)
cp -f $BASEDIR/.tmux.conf ~/

# VIM configuration
VUNDLE_INSTALL_DIR=~/.vim/bundle/Vundle.vim
if ! [ -d "$VUNDLE_INSTALL_DIR" ]
then
	git clone https://github.com/gmarik/Vundle.vim.git $VUNDLE_INSTALL_DIR
fi
cp -f $BASEDIR/.vimrc ~/
mkdir -p ~/.vim/backup
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/undo
vim +PluginInstall +qall
