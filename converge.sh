#!/bin/bash
BASEDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)

rm -rf ~/.dotfiles
cp -r $BASEDIR/.dotfiles ~/

# enable sourcing additional bash_aliases config files from ~/.dotfiles/bash_aliases.d
if ! grep -q .dotfiles/bash_aliases.d ~/.bash_aliases; then
  cat << 'EOF' >> ~/.bash_aliases

for file in $HOME/.dotfiles/bash_aliases.d/*
do . $file
done
EOF
fi

# checkout some repos
mkdir -p ~/development/spikes/R
mkdir -p ~/development/helios/vm

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

SHINY_JIRA_PROJECT_ANALYSIS_DIR=~/development/shiny-jira-project-analysis
if ! [ -d "$SHINY_JIRA_PROJECT_ANALYSIS_DIR" ]
then
  git clone git@github.com:pghalliday/shiny-jira-project-analysis.git $SHINY_JIRA_PROJECT_ANALYSIS_DIR
fi

HELIOS_LOCAL_DEV_VM_SETUP_DIR=~/development/helios/local-dev-vm-setup
if ! [ -d "$HELIOS_LOCAL_DEV_VM_SETUP_DIR" ]
then
  git clone git@gitlab.upc.biz:helios/local-dev-vm-setup.git $HELIOS_LOCAL_DEV_VM_SETUP_DIR
fi

HELIOS_JIRA_PROJECT_ANALYSIS_DIR=~/development/helios-jira-project-analysis
if ! [ -d "$HELIOS_JIRA_PROJECT_ANALYSIS_DIR" ]
then
  git clone git@gitlab.upc.biz:phalliday/helios-jira-project-analysis.git $HELIOS_JIRA_PROJECT_ANALYSIS_DIR
fi

GRUNT_MOCHA_TEST_DIR=~/development/grunt-mocha-test
if ! [ -d "$GRUNT_MOCHA_TEST_DIR" ]
then
  git clone git@github.com:pghalliday/grunt-mocha-test.git $GRUNT_MOCHA_TEST_DIR
fi
