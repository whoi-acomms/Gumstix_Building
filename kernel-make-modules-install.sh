#!/bin/bash

source gumstix_dev_host/kernel-dev.env

cd linux
version=$(grep UTS_RELEASE include/generated/utsrelease.h | sed 's/.*\"\(.*\)\"/\1/')
# copy modules to another folder for later use
make modules_install INSTALL_MOD_PATH=../modules-$version
cd ..

# rm -rf modules-XXXX
# rm -rf modules-XXXX.tgz
# mkdir -p modules-XXXX

# tar up the modules
cd modules-$version
tar zcvf ../modules-$version.tgz .
cd ..

