#!/bin/bash

source kernel-dev.env

cd linux
make modules_install INSTALL_MOD_PATH=../modules-XXXX
cd ..
tar zcvf modules-XXXX.tgz modules-XXXX

