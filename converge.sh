#!/bin/bash
BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)

rm -rf ~/.dotfiles
cp -r $BASEDIR/.dotfiles ~/

# enable sourcing additional bashrc config files from ~/.dotfiles/bashrc.d
if ! grep -q .dotfiles/bashrc.d ~/.bashrc; then
  cat << 'EOF' >> ~/.bashrc

for file in $HOME/.dotfiles/bashrc.d/*
do . $file
done
EOF
fi

# enable sourcing additional bash_aliases config files from ~/.dotfiles/bash_aliases.d
if ! grep -q .dotfiles/bash_aliases.d ~/.bash_aliases; then
  cat << 'EOF' >> ~/.bash_aliases

for file in $HOME/.dotfiles/bash_aliases.d/*
do . $file
done
EOF
fi

# base16 theme configuration (also see bashrc.d/base16.sh and .vimrc)
BASE16_SHELL_INSTALL_DIR=~/.config/base16-shell
if ! [ -d "$BASE16_SHELL_INSTALL_DIR" ]
then
	git clone https://github.com/chriskempson/base16-shell.git $BASE16_SHELL_INSTALL_DIR
fi

# bash git prompt configuration (also see bashrc.d/git-bash-prompt.sh)
BASH_GIT_PROMPT_INSTALL_DIR=~/.config/bash-git-prompt
if ! [ -d "$BASH_GIT_PROMPT_INSTALL_DIR" ]
then
	git clone git@github.com:magicmonty/bash-git-prompt.git $BASH_GIT_PROMPT_INSTALL_DIR
fi

# tmux configuration (also see bash_aliases.d/tmux.sh)
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

# checkout some repos
mkdir -p ~/development/spikes

DOTFILES_DIR=~/development/dotfiles
if ! [ -d "$DOTFILES_DIR" ]
then
  git clone git@github.com:pghalliday/dotfiles.git $DOTFILES_DIR
fi

TASKS_DIR=~/development/tasks
if ! [ -d "$TASKS_DIR" ]
then
  git clone git@github.com:pghalliday/tasks.git $TASKS_DIR
fi

JIRA_PROJECT_ANALYSIS_DIR=~/development/jira-project-analysis
if ! [ -d "$JIRA_PROJECT_ANALYSIS_DIR" ]
then
  git clone git@github.com:pghalliday/jira-project-analysis.git $JIRA_PROJECT_ANALYSIS_DIR
fi

GRUNT_MOCHA_TEST_DIR=~/development/grunt-mocha-test
if ! [ -d "$GRUNT_MOCHA_TEST_DIR" ]
then
  git clone git@github.com:pghalliday/grunt-mocha-test.git $GRUNT_MOCHA_TEST_DIR
fi
