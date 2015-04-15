#!/bin/bash

# This script is mostly conceptual, to document how we build the Gumstix boot and rootfs.
# It might run as a script, but for now it is probably best to call the individual scripts by hand in order.

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

##########################################################################
# Now we have configured the build host PC, built u-boot, kernel, kernel modules, and mostly finished rootfs.
# Using that work, now we can copy/rsync those files to multiple SD cards, one for each Gumstix we have.
##########################################################################

# Insert SD card into USB reader. Assumed to be at /dev/sdb for this script.

# partition SD card
sudo mk2partsd /dev/sdb

# First, copy files to the boot partition. ORDER MATTERS HERE!

# mount SD card's boot partition
sudo mount /dev/sdb1 /mnt/boot
# copy boot files: MLO *MUST* be copied first!
sudo ./gumstix_dev_host/copy_boot_files.sh /mnt/boot
# unmount SD card's boot partition
sudo umount /mnt/boot

# Now rsync/copy/configure the rootfs partition

# mount SD card's rootfs partition
sudo mount /dev/sdb2 /mnt/rootfs
#
# rsync rootfs files to SD card's rootfs partition
cd rootfs
sudo rsync -aP . /mnt/rootfs
cd /mnt/rootfs/home/acomms
#
# clone the Acomms git repositories into Gumstix /home/acomms/
sudo git clone https://github.com/whoi-acomms/Gumstix_Testing.git
sudo git clone https://github.com/whoi-acomms/umodemd.git
sudo git clone https://github.com/whoi-acomms/pyacomms.git
cd /mnt/rootfs/home
sudo chown -R acomms.acomms acomms
#
# unpack kernel modules-XXXX.tgz into /mnt/rootfs/lib
cd /mnt/rootfs
sudo tar zxvf modules-3.2.51whoi-acomms-00069-g19edbad.tgz
#
# update MAC address if desired in /etc/network/interfaces
#
# Install the GPIO init.d script to export the GPIO interfaces at system boot
# sudo cp /home/acomms/Gumstix_Testing/scripts/init_scripts/acomms-gpio /etc/init.d/.
# cd /etc/init.d
# sudo update-rc.d acomms-gpio defaults
#
# unmount SD card's rootfs partition
sudo umount /mnt/rootfs

# still to document: configuring rootfs using configscript.sh and preseed.cfg
