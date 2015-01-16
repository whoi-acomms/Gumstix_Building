#!/bin/sh

echo "This script is quite a hack, but should get the job done..."

echo "Install the debian packages required by the host."

apt-get install emdebian-archive-keyring
apt-get install multistrap
apt-get install qemu
apt-get install qemu-user-static
apt-get install binfmt-support
apt-get install dpkg-cross
apt-get install putty
apt-get install gparted
apt-get install git
apt-get install subversion
apt-get install build-essential
apt-get install gcc
apt-get install patch
apt-get install help2man
apt-get install diffstat
apt-get install texi2html
apt-get install texinfo
apt-get install libncurses5-dev
apt-get install cvs
apt-get install gawk
apt-get install python-dev
apt-get install python-pysqlite2
apt-get install unzip
apt-get install chrpath
apt-get install ccache
apt-get install u-boot-tools
apt-get install fakeroot


echo "Install the cross-compiler debian packages required by the host."

cp emdebian.list /etc/apt/sources.list.d/emdebian.list
apt-get install gcc-4.7-arm-linux-gnueabihf

#echo "List the armhf packages"
#apt-cache search armhf

