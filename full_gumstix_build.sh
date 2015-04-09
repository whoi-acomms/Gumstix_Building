#!/bin/bash

# this script is an ugly hack, but hopefully streamlines the process

# Bring the host/build computer up to speed with tools, etc.
sudo ./gumstix_dev_host/host_apt_install.sh

# Install ARM-HF cross-compiler.
sudo ./gumstix_dev_host/install_cross_compiler.sh

# Get the u-boot source code from github, configure it, and build it.
./gumstix_dev_host/u-boot-get-and-build.sh

# Get the Linux kernel source code from github, configure it, and build it
./gumstix_dev_host/kernel-get-and-build.sh

# make the boot directory and copy files to it
mkdir -p ./boot
./gumstix_dev_host/copy_boot_files.sh boot

# install and tar up the Linux kernel modules
./gumstix_dev_host/kernel-make-modules-install.sh

# build the Gumstix root file system
./gumstix_dev_host/create-gumstix.sh   # uses preseed.cfg and configscript.sh

# insert SD card into USB reader

# partition SD card
sudo mk2partsd /dev/sdb

# mount SD card's boot partition
sudo mount /dev/sdb1 /mnt/boot

# copy boot files
sudo ./gumstix_dev_host/copy_boot_files.sh /mnt/boot

# unmount SD card's boot partition
sudo umount /mnt/boot

# mount SD card's rootfs partition
sudo mount /dev/sdb2 /mnt/rootfs

# rsync rootfs files to SD card's rootfs partition
cd rootfs
rsync -aP . /mnt/rootfs
# extract modules-version.tgz onto /mnt/rootfs/lib/
# update MAC address
# add acomms-gpio file
# get pyacomms
# get Gumstix_Configuration
cd ..

# unmount SD card's rootfs partition
sudo umount /mnt/rootfs

# to do: still need to configure...
