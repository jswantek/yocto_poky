#!/bin/bash -e

echo "Source the pokey"
cd /poky
. ./oe-init-build-env /poky/workdir
echo "Build the pokey [$1]"
bitbake $1
