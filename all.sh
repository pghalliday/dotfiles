#!/bin/bash

set -e

rm -rf ./cookbooks/
chef exec berks vendor ./cookbooks/
sudo chef exec chef-client -z -r workstation
./converge.sh
