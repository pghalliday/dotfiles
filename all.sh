#!/bin/bash

set -e

chef exec berks vendor ./cookbooks/
sudo chef exec chef-client -z -r workstation
./converge.sh
