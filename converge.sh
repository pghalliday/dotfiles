#!/bin/bash

set -e

sudo chef-client -z -j ~/.dotfiles/attributes.json -r workstation
