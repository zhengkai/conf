#!/bin/sh
date '+%Y-%m-%d %H:%M:%S'
echo
arch
lsb_release -c -s
echo

export DEBIAN_FRONTEND=noninteractive
sudo apt -y -q update
sudo apt -y -q -o Dpkg::Options::="--force-confnew" dist-upgrade
sudo apt -y -q autoremove
sudo apt -y -q autoclean

sudo rm -f /etc/ssl/certs/CNNIC_ROOT.pem || :
sudo rm -f /usr/share/ca-certificates/mozilla/CNNIC_ROOT.crt || :

echo
date '+%Y-%m-%d %H:%M:%S'
