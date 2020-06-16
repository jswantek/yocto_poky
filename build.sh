#!/bin/bash -e

if ! docker volume ls | grep -q yoctobuild; then
    echo "Create docker volume"
    docker volume create --name yoctobuild
    docker run -it --rm -v yoctobuild:/poky/build busybox chown -R 30000:30000 /poky/build
fi
echo "Building the yocto build container..."
docker build . --pull -f Dockerfile -t yocto_pokey:latest

CMD=""
if [ -n "$1" ]; then
    CMD="./build_poky.sh $1"
fi

echo "Starting the yocto build container..."
docker run -it --rm  \
  -v yoctobuild:/poky/build \
  -w /poky \
  yocto_pokey:latest $CMD
