#!/bin/bash

# this script is an ugly hack, but hopefully streamlines the process

STARTTIME=$(date +%s)

# save the current working directory
pushd .

# insert SD card into USB reader
# and umount if it automounts, so it can be partitioned.
#
# Ubuntu: dconf-editor, org.gnome.desktop.media-handling, uncheck automount
# Ubuntu: dconf-editor, org.gnome.desktop.media-handling, uncheck automount-open
# Close dconf-editor (it seems to save itself?)
#
# Also, /etc/fstab has been edited to add the lines below
# so that /dev/sdb1 and /dev/sdb2 come up where desired.
# noauto doesn't quite seem to work as I had expected, though.
#
# Added to /etc/fstab:
# /dev/sdb1 /mnt/boot vfat noauto 0 0
# /dev/sdb2 /mnt/rootfs ext3 noauto 0 0

sudo umount /mnt/boot
sudo umount /mnt/rootfs

# exit with error if either /mnt/boot or /mnt/rootfs are mounted
sudo mount --fake /mnt/boot   || aplay /home/acomms/sounds/sd_card_error.wav && exit 1
sudo mount --fake /mnt/rootfs || aplay /home/acomms/sounds/sd_card_error.wav && exit 1

# partition SD card
sudo ./gumstix_dev_host/mk2partsd /dev/sdb

# mount SD card's boot partition
sudo mount /dev/sdb1 /mnt/boot

# copy boot files
sudo ./gumstix_dev_host/copy_boot_files.sh /mnt/boot

# unmount SD card's boot partition
echo sleep 30
sleep 30
sync
sudo umount /mnt/boot

# mount SD card's rootfs partition
sudo mount /dev/sdb2 /mnt/rootfs || aplay /home/acomms/sounds/sd_card_error.wav && exit 1

# update rootfs git repositories
cd rootfs
cd home/acomms/Gumstix_Testing
git pull
cd ../Gumstix_Building
git pull
cd ../pyacomms
git pull
cd ../umodemd
git pull
cd ../../..

# rsync rootfs files to SD card's rootfs partition
sudo rsync -aP . /mnt/rootfs
echo sleep 30
sleep 30
sync

# unpack kernel modules-XXX.tgz into /mnt/rootfs/lib
cd /mnt/rootfs
sudo tar zxvf /home/acomms/GumstixDevelopment/debian7_armhf/boot-3.2.68/modules-3.2.68whoi-acomms-00068-gc4a52ab.tgz
# or for kernel-3.2.51: modules-3.2.51whoi-acomms-00069-g19edbad.tgz
echo sleep 30
sleep 30
sync

# update MAC address if desired in /mnt/rootfs/etc/network/interfaces

# return to the original directory, so we can unmount /mnt/rootfs
popd

# unmount SD card's rootfs partition
echo sleep 30
sleep 30
sync
sudo umount /mnt/rootfs

aplay /home/acomms/sounds/sd_card_done.wav

ENDTIME=$(date +%s)
echo "Elapsed time: $(($ENDTIME - $STARTTIME)) seconds."
date

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

