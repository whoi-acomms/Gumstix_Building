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

# clone the Acomms git repositories into Gumstix /home/acomms
sudo git clone https://github.com/whoi-acomms/Gumstix_Testing.git
sudo git clone https://github.com/whoi-acomms/Gumstix_Building.git
sudo git clone https://github.com/whoi-acomms/pyacomms.git
sudo git clone https://github.com/whoi-acomms/umodemd.git
cd /mnt/rootfs/home
sudo chown -R acomms.acomms acomms
cd /mnt/rootfs
cp ./home/acomms/Gumstix_Testing/scripts/init.d/acomms-gpio /etc/init.d/.
sudo chroot /mnt/rootfs
cd /etc/init.d
update-rc.d acomms-gpio defaults

##########################################################################
# Now we have configured the build host PC, built u-boot, kernel, kernel modules, and mostly finished rootfs.
# Using that work, now we can copy/rsync those files to multiple SD cards, one for each Gumstix we have.
# See install_kernel.sh
##########################################################################

