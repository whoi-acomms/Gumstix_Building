#!/bin/sh

echo "Install the cross-compiler debian packages required by the host."

apt-get install emdebian-archive-keyring

# hackishly install the emdebian list
cp emdebian.list /etc/apt/sources.list.d/emdebian.list

apt-get install gcc-4.7-arm-linux-gnueabihf

#echo "List the armhf packages"
#apt-cache search armhf

