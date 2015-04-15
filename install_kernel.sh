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
sync
sudo umount /mnt/boot

# mount SD card's rootfs partition
sudo mount /dev/sdb2 /mnt/rootfs

# rsync rootfs files to SD card's rootfs partition
cd rootfs
sudo rsync -aP . /mnt/rootfs

# unpack kernel modules-XXX.tgz into /mnt/rootfs/lib
cd /mnt/rootfs
sudo tar zxvf /home/acomms/GumstixDevelopment/debian7_armhf/boot-3.2.68/modules-3.2.68whoi-acomms-00068-gc4a52ab.tgz
# or for kernel-3.2.51: modules-3.2.51whoi-acomms-00069-g19edbad.tgz

# update MAC address if desired in /mnt/rootfs/etc/network/interfaces

# unmount SD card's rootfs partition
sync
sudo umount /mnt/rootfs

# to do: still need to configure...

# Already done in the rootfs copy:
## clone the Acomms git repositories into Gumstix /home/acomms
#sudo git clone https://github.com/whoi-acomms/Gumstix_Testing.git
#sudo git clone https://github.com/whoi-acomms/Gumstix_Building.git
#sudo git clone https://github.com/whoi-acomms/pyacomms.git
#sudo git clone https://github.com/whoi-acomms/umodemd.git
#cd /mnt/rootfs/home
#sudo chown -R acomms.acomms acomms
#cd /mnt/rootfs
#cp ./home/acomms/Gumstix_Testing/scripts/init.d/acomms-gpio ./etc/init.d/.


