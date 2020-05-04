#!/bin/sh
date '+%Y-%m-%d %H:%M:%S'
echo
arch
lsb_release -c -s
echo

sudo DEBIAN_FRONTEND=noninteractive /usr/bin/apt-get -y -q update
sudo DEBIAN_FRONTEND=noninteractive /usr/bin/apt-get -y -q -o Dpkg::Options::="--force-confnew" dist-upgrade
sudo DEBIAN_FRONTEND=noninteractive /usr/bin/apt-get -y -q autoremove
sudo DEBIAN_FRONTEND=noninteractive /usr/bin/apt-get -y -q autoclean

sudo rm -f /etc/ssl/certs/CNNIC_ROOT.pem || :
sudo rm -f /usr/share/ca-certificates/mozilla/CNNIC_ROOT.crt || :

DIR=`readlink -f "$0"` && DIR=`dirname "$DIR"` && cd "$DIR" || exit 1
./clean-motd.sh

echo
date '+%Y-%m-%d %H:%M:%S'
