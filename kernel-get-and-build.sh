#!/bin/bash


### Block 1: Get the source code (possibly already done)
# Clone (or "checkout" in SVN parlance) the Github Linux Kernel repository
git clone -n git://github.com/whoi-acomms/linux.git
cd linux
# Shows all the available branches
git branch -a
# Checkout this branch from the remote repository and "track" it (future changes will be merged with "git pull"
git checkout -t origin/whoi-3.2.51

### Block 2: Do the actual build
# Before building, make sure you commit and push any changes
# to check use "git status" which should show no working changes
# Set environmental variable to indicate ARM architecture build and cross-compilers to use
source gumstix_dev_host/kernel-dev.env
# Copy the committed kernel configuration into the location required for the build
cp arch/arm/configs/overo_defconfig .config
# Make the version header
make include/linux/version.h
# Make the kernel binary for Gumstix
make uImage
# Make the kernel modules
make modules
cd ..

