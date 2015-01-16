#!/bin/bash

# Bring the host/build computer up to speed with all tools and cross-compilers, etc.
# Steps 1 and 2 of the documentation.
sudo host_apt_install.sh

# Get the u-boot source code from github, configure it, and build it.
u-boot-get-and-build.sh

# Get the Linux kernel source code from github, configure it, and build it
kernel-get-and-build.sh

# copy the Linux kernel modules
kernel-make-modules-install.sh

# build the Gumstix root file system

