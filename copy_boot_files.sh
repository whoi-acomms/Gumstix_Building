#!/bin/bash

BOOTDIR=$1

# make the boot directory
#mkdir -p ${BOOTDIR}

cp u-boot/MLO ${BOOTDIR}/.	# copying MLO must be done first, at least onto SD card
cp u-boot/u-boot.img ${BOOTDIR}/.
#cp linux/arch/arm/boot/uImage ${BOOTDIR}/.
#cp linux/.config ${BOOTDIR}/kernel_config_3.2.68
cp boot-3.2.68/uImage ${BOOTDIR}/.
cp boot-3.2.68/kernel_config_3.2.68 ${BOOTDIR}/.
cp gumstix_dev_host/boot-README.txt ${BOOTDIR}/README.txt

