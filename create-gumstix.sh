#!/bin/bash

mkdir -p rootfs
sudo multistrap -f ./gumstix_dev_host/debian_rootfs-debian7.conf -d ./rootfs
cd rootfs
sudo cp /usr/bin/qemu-arm-static usr/bin
sudo mount -o bind /dev dev
mkdir -p tmp/preseeds
sudo cp  ../gumstix_dev_host/preseed.cfg tmp/preseeds
sudo cp  ../gumstix_dev_host/configscript.sh .
sudo chroot . /bin/bash -c /configscript.sh
sudo umount dev
sudo rm configscript.sh

