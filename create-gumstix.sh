#!/bin/bash

sudo multistrap -f wheezy-debian7-hf.conf -d rootfs
cd rootfs
sudo cp /usr/bin/qemu-arm-static usr/bin
sudo mount -o bind /dev dev
mkdir -p tmp/preseeds
sudo cp  ../preseed.cfg tmp/preseeds
sudo chroot . /bin/bash -c /configscript.sh
sudo umount dev
sudo rm configscript.sh
