#! /bin/bash -e

DISK="/dev/disk/by-uuid/5e9a7f92-143a-41dd-9fab-82743af6f145"

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

sudo ls "$DISK" || exit

sudo mount "$DISK" /media/move
