#!/bin/bash

set -e

./build.sh
(cd ./vendor/ && ./converge.sh)
