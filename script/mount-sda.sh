#! /bin/bash -e

if [ "${HOSTNAME,,}" != "decima" ]; then
	echo "decima only"
	exit 1
fi

if [ -d "/media/move/bt" ]; then
	exit
fi

UPSEC=$(cut -d. -f1 < /proc/uptime)
if [ "$UPSEC" -lt 600 ]; then
	exit 1
fi

sudo ls /dev/sda1 || exit

sudo mount /dev/sda1 /media/move
