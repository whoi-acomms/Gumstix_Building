#!/bin/bash

BOOTDIR=$1

# make the boot directory
#mkdir -p ${BOOTDIR}

#cp u-boot/MLO ${BOOTDIR}/.	# copying MLO must be done first, at least onto SD card
#sync
#cp u-boot/u-boot.img ${BOOTDIR}/.
#cp linux/arch/arm/boot/uImage ${BOOTDIR}/.
#cp linux/.config ${BOOTDIR}/kernel_config_3.2.68
#cp gumstix-dev-host/boot-README.txt ${BOOTDIR}/README.txt

echo Copying MLO
cp boot-3.2.68/MLO ${BOOTDIR}/.	# copying MLO must be done first, at least onto SD card
echo sleep 30
sleep 30
sync
echo Copying u-boot.img, uImage, kernel_config, README.txt
cp boot-3.2.68/u-boot.img ${BOOTDIR}/.
cp boot-3.2.68/uImage ${BOOTDIR}/.
cp boot-3.2.68/kernel_config_3.2.68 ${BOOTDIR}/.
cp boot-3.2.68/README.txt ${BOOTDIR}/.
echo sleep 30
sleep 30
sync
echo Done with copy_boot_files.sh

