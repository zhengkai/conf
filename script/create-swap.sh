#!/bin/bash -ex

if [ "$EUID" -ne 0 ]; then
	sudo "$0"
	exit
fi

mkdir -p /opt/images
rm -rf /opt/images/swap
dd if=/dev/zero of=/opt/images/swap bs=1024 count=2048000
# chmod 600 /opt/images/swap
mkswap /opt/images/swap
swapon /opt/images/swap

free
