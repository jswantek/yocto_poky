#!/bin/bash -e

if ! docker volume ls -q | grep -q "^yoctobuild$"; then
    echo "Create docker volume"
    docker volume create --name yoctobuild
    docker run -it --rm -v yoctobuild:/poky/workdir busybox chown -R 1000:1000 /poky/workdir
fi
echo "Pull down the latest CROPS container..."
docker build . --pull -f Dockerfile -t yocto_pokey:latest

CMD=""
if [ -n "$1" ]; then
    CMD="/poky/build_poky.sh $1"
fi

echo "Starting the yocto build container..."
# docker run -it --rm  \
#   -v yocto:/poky/workdir \
#   -w /pokey \
#   yocto_pokey:latest --workdir=/poky/workdir

# docker run --rm -it -v yocto:/workdir yocto_pokey:latest --workdir=/workdir

docker run -it --rm  \
  -v yoctobuild:/poky/workdir \
  yocto_pokey:latest --workdir=/poky/workdir $CMD
