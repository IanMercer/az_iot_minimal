Minimal example of Azure IOT code using a pre-build armhf debian package for the Azure IoT SDK

_I would rather not have to do this but I could not find an Azure IoT SDK prebuilt for Raspbian and the
instructions to build one are complex and long. If you want to repeat what I've done here, see the
appendix below._

Running the sample
====

Add my repository key:

    wget https://signswiftdebian.blob.core.windows.net/apt/key/deb.gpg.key
    sudo apt-key add deb.gpg.key

Edit `/etc/apt/sources.list` and add the following line:

    deb https://signswiftdebian.blob.core.windows.net/apt/ buster main

Now download the pre-built Azure IoT SDK package that I made:

    sudo apt-get update
    sudo apt-get install azure_iot_sdks

Add your connection string to main.c (this is just one of the Azure sample files, no changes).

Make and run it

    make
    sudo chmod+x main
    ./main

It works! and you didn't need to understand CMake, Parson, a huge directory tree, a complex build system,
mocking frameworks, testing code, ... 

_This is what a minimal sample for Azure IoT on Raspberry Pi  should look like IMHO._



APPENDIX
====

_You don't need to do any of this if you use my pre-built Debian package. This is mostly here so I don't need my notes on how to do it next time._

How to build your own Debian package for the Azure IoT SDK for Raspberry Pi.
----

Either build the SDK on a Raspberry Pi or install everything you need to cross-compile to Raspberry Pi 
and cross-compile it. 

See https://desertbot.io/blog/how-to-cross-compile-for-raspberry-pi for building in Docker.

See https://stackoverflow.com/a/58559140/224370 for building it from the shell.


e.g.

````
# To get the rootfs which is required here, use:
# rsync -rl --delete-after --safe-links pi@192.168.1.PI:/{lib,usr} $HOME/rpi/rootfs
export RASPBIAN_ROOTFS=$HOME/pi/pi4/rootfs
export PATH=/opt/cross-pi-gcc/bin:/opt/cross-pi-gcc/libexec/gcc/arm-linux-gnueabihf/8.3.0:$PATH
export RASPBERRY_VERSION=2

cmake -DCMAKE_TOOLCHAIN_FILE=$DIR/Toolchain-rpi.cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DLINUX=TRUE $DIR/sdk
cmake --build $DIR/build
````

Add the following lines to /sdk/CMakelists.txt

````
set(CPACK_PACKAGE_NAME "azure_iot_sdks")
set(CPACK_PACKAGE_VENDOR "Yourname or Microsoft")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Your name")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Cross-compiled copy of Microsoft's Azurt IoT SDK")
SET(CPACK_GENERATOR "DEB")
set(CPACK_VERBATIM_VARIABLES true)
set(CPACK_PACKAGE_VERSION_MAJOR 1)
set(CPACK_PACKAGE_VERSION_MINOR 0)
set(CPACK_PACKAGE_VERSION_PATCH 0)
SET(CPACK_DEBIAN_PACKAGE_DEPENDS "libssl-dev, libcurl4-openssl-dev, curl")
set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE "armhf")
set(CPACK_DEBIAN_FILE_NAME DEB-DEFAULT)
include(CPack)
````

Now run this in the same location you ran the build:

````
# Pick what kind of package you want from: "STGZ;TGZ;DEB"
cpack -C "Release" -G "DEB"
````
