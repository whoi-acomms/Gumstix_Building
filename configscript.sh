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

adduser --gecos "" --disabled-login mituser
echo "root:mitmit" | chpasswd 
echo "mituser:mitmit" | chpasswd

echo "mituser       ALL=(ALL) ALL" >> /etc/sudoers
echo "proc            /proc           proc    defaults        0       0"  > /etc/fstab
echo "nameserver 8.8.8.8" > /etc/resolv.conf

echo "gambero-$(date +%Y-%m-%d)"  > /etc/hostname
echo "127.0.0.1   gambero-$(date +%Y-%m-%d)"  >> /etc/hosts
echo "T0:2345:respawn:/sbin/getty -L 115200 ttyO2 vt102" >> /etc/inittab

ln -s /usr/bin/zile /usr/local/bin/emacs

cat <<EOF > /etc/network/interfaces
auto lo
iface lo inet loopback
 
auto usb0
iface usb0 inet static
address 10.42.0.20
netmask 255.255.255.0
gateway 10.42.0.1
EOF

echo "g_ether" >> /etc/modules

for key in /tmp/*apt-key; do
    apt-key add $key
done

umount proc
