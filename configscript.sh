#!/bin/sh

export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true
export LC_ALL=C LANGUAGE=C LANG=C
/var/lib/dpkg/info/dash.preinst install
if [ -d /tmp/preseeds/ ]; then
        for file in `ls -1 /tmp/preseeds/*`; do
        debconf-set-selections $file
        done
fi
dpkg --configure -a
mount proc -t proc /proc
dpkg --configure -a

#adduser --gecos "" --disabled-login acomms
#echo "root:mitmit" | chpasswd 
adduser acomms
echo "acomms:acomms" | chpasswd

echo "acomms       ALL=(ALL) ALL" >> /etc/sudoers
echo "proc            /proc           proc    defaults        0       0"  > /etc/fstab
echo "nameserver 8.8.8.8" > /etc/resolv.conf

#echo "test-gumstix-acomms2"  > /etc/hostname
#echo "127.0.0.1   test-gumstix-acomms2"  >> /etc/hosts
echo "gumstix-$(date +%Y-%m-%d)"  > /etc/hostname
echo "127.0.0.1   gumstix-$(date +%Y-%m-%d)"  >> /etc/hosts
echo "T0:2345:respawn:/sbin/getty -L 115200 ttyO2 vt102" >> /etc/inittab

ln -s /usr/bin/zile /usr/local/bin/emacs

cat <<EOF > /etc/network/interfaces
auto lo
iface lo inet loopback
 
auto eth0
# DHCP: test-gumstix-acomms2.whoi.edu, 128.128.208.102
iface eth0 inet dhcp
hwaddress ether 00:41:43:4F:4D:04

# static IP
#iface eth0 inet static
#address 10.42.0.20
#netmask 255.255.255.0
#gateway 10.42.0.1

# Wireless:
#allow-hotplug wlan0
#iface wlan0 inet dhcp
#    wireless-mode managed
#    wpa-ssid acommsnet
#    wpa-psk whoi1930

EOF

echo "g_ether" >> /etc/modules
echo "g_serial" >> /etc/modules
#echo "libertas_sdio" >> /etc/modules
echo "blacklist libertas_sdio" > /etc/modprobe.d/libertas_sdio_blacklist.conf

# apt-get update
# apt-get install python python-dev python-setuptools python-pip
# pip install pyserial
# pip install python-pytun
# easy_install bitstring
# easy_install bidict
# apt-get install ...

# apt-get clean

for key in /tmp/*apt-key; do
    apt-key add $key
done

svn checkout https://dev-acomms.whoi.edu/svn/Platforms/Gumstix_Configuration/ /home/acomms/Gumstix_Configuration

umount proc
