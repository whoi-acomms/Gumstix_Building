#!/bin/bash

# make the boot directory
mkdir -p boot
cp u-boot/MLO boot/	# this must be done first, at least onto SD card
cp u-boot/u-boot.img boot/
cp linux/arch/arm/boot/uImage boot/
cp linux/.config boot/kernel_config_XXXX
cp gumstix_dev_host/boot-README.txt boot/README.txt

