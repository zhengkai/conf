#! /bin/bash -e

if [ "${HOST,,}" != "decima" ]; then
	echo "decima only"
	exit 1
fi

if [ -d "/media/move/bt" ]; then
	exit
fi

UPSEC=$(cat /proc/uptime | cut -d. -f1)
if [ "$UPSEC" -lt 1000 ]; then
	exit 1
fi

sudo ls /dev/sda1 || exit

sudo mount /dev/sda1 /media/move
