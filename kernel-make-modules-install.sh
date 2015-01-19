#!/bin/bash

source gumstix_dev_host/kernel-dev.env

cd linux
make modules_install INSTALL_MOD_PATH=../modules-XXXX
cd ..

# rm -rf modules-XXXX
# rm -rf modules-XXXX.tgz
# mkdir -p modules-XXXX

cd modules-XXXX
tar zcvf ../modules-XXXX.tgz .
cd ..

