#!/bin/bash -e

echo "Source the pokey"
. ./oe-init-build-env build
echo "Build the pokey"
if [ -n "$1" ]; then
    bitbake $1
fi
