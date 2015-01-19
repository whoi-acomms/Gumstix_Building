#!/bin/bash

# this script is an ugly hack, but hopefully streamlines the process

cd ..

# Bring the host/build computer up to speed with all tools and cross-compilers, etc.
# Steps 1 and 2 of the documentation.
sudo ./gumstix_dev_host/host_apt_install.sh

# Get the u-boot source code from github, configure it, and build it.
./gumstix_dev_host/u-boot-get-and-build.sh

# Get the Linux kernel source code from github, configure it, and build it
./gumstix_dev_host/kernel-get-and-build.sh

# make the boot directory and copy files to it
./gumstix_dev_host/copy_boot_files.sh

# install and tar up the Linux kernel modules
./gumstix_dev_host/kernel-make-modules-install.sh

# build the Gumstix root file system
mkdir -p rootfs
sudo multistrap -f ./gumstix_dev_host/debian_rootfs_debian7.conf -d rootfs

# to do: still need to mount SD card, rsync, configure...

