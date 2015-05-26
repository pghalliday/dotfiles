#!/bin/bash -e
DIR=$(cd "$(dirname "$0")"; pwd)
ATTRIBUTES=$HOME/.dotfiles/attributes.json
sudo -i -- sh -c "echo $DIR && cd $DIR && pwd && chef-client -z -j $ATTRIBUTES -r workstation"
