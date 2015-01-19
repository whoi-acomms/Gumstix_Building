#!/bin/bash

source kernel-dev.env

cd linux
make modules_install INSTALL_MOD_PATH=../modules-XXXX
cd ..
# rm -rf modules-XXXX
# mkdir -p modules-XXXX
cd modules-XXXX
tar zcvf ../modules-XXXX.tgz modules-XXXX
cd ..

