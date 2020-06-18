# WIP Yocto Container Build

Work-in-progress to build a Yocto Poky build from scratch using a CROPS provided
Docker container (https://hub.docker.com/r/crops/poky).

This repo started from git://git.yoctoproject.org/poky.git (tag: yocto-3.1)

```
git clone git://git.yoctoproject.org/poky.git
git remote add joe git@github.com:jswantek/yocto_poky.git
git checkout yocto-3.1 --orphan joe_yocto-3.1
git commit
git push joe joe_yocto-3.1
```

Then added `build.sh` and `Dockerfile` to build the Yocto Poky in a Docker container

This demonstrates how to build a Yocto Poky OS image within a Docker container.
The source code for the OS to build (i.e. the poky clone outlined above) is copied
into the build container (see: `Dockerfile`).  Demonstrating how this could be
done for the ARM build and future SAGE OS builds.

## Usage

No matter the method of invoking the build (manual or automatic) this will produce a finished build within the `yoctobuild` Docker volume.

### Launch Manually

To launch build container without building (i.e. to see previously built artifacts)

```
./build.sh
```

You can manually invoke the build via

```
source oe-init-build-env
bitbake core-image-minimal
```
### Auto-build

The container can auto build the OS image specified on the `./build.sh` command line

```
./build.sh <OS image to build>
```

Example

```
./build.sh core-image-minimal
```

## Testing

To test run the built image using `qemu` you can use the following command

```
runqemu qemux86-64
```

Note: you will need to execute the `source oe-init-build-env` to get access to
the `runqemu` tool.

## Build Resources
- https://www.yoctoproject.org/docs/3.1/brief-yoctoprojectqs/brief-yoctoprojectqs.html
- https://www.yoctoproject.org/docs/3.1/dev-manual/dev-manual.html#setting-up-to-use-crops
- https://github.com/crops/docker-win-mac-docs/wiki/Mac-Instructions

How to create a Samba share to access the `yoctobuild` Docker volume
- https://github.com/crops/docker-win-mac-docs/wiki/Mac-Instructions
