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
./gumstix_dev_host/copy_boot_files.sh

# install and tar up the Linux kernel modules
./gumstix_dev_host/kernel-make-modules-install.sh

# build the Gumstix root file system
./gumstix_dev_host/create-gumstix.sh   # uses preseed.cfg and configscript.sh

# to do: still need to mount SD card, rsync, configure...

# insert SD card into USB reader
# partition SD card
# make boot directory
# mount SD card's boot partition
# copy boot files
# unmount SD card's boot partition

# rsync rootfs files to SD card's rootfs partition

