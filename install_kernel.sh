#!/bin/bash

# this script is an ugly hack, but hopefully streamlines the process


# insert SD card into USB reader
# and umount if it automounts, so it can be partitioned

# partition SD card
sudo ./gumstix_dev_host/mk2partsd /dev/sdb

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

# unpack kernel modules
cd /mnt/rootfs
sudo tar zxvf /home/acomms/GumstixDevelopment/debian7_armhf/boot-3.2.68/modules-3.2.68whoi-acomms-00068-gc4a52ab.tgz

# unmount SD card's rootfs partition
sudo umount /mnt/rootfs

# to do: still need to configure...

