#!/bin/bash

DISK="/dev/disk/by-uuid/14E0-E609"

if [ "${HOSTNAME,,}" != "decima" ]; then
	echo "decima only"
	exit 1
fi

if [ -d "/media/black/video" ]; then
	echo
	# exit
fi

sudo ls "$DISK" || exit

ID=$(id -u zhengkai)
echo sudo mount -t exfat -o "uid=${ID},gid=${ID}" "$DISK" /media/black
