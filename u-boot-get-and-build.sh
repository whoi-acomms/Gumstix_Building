#!/bin/bash

source gumstix_dev_host/kernel-dev.env

git clone -n git://github.com/whoi-acomms/u-boot.git
cd u-boot
git branch -a
git checkout mainline
make omap3_overo_config
make all
cd ..


