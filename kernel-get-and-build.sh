#!/bin/bash

source kernel-dev.env

git clone -n git://github.com/whoi-acomms/linux.git
cd linux
git branch -a
git checkout -t origin/whoi-3.2
cp arch/arm/configs/overo_defconfig .config
make include/linux/version.h
make uImage
make modules
cd ..

