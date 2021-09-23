#!/bin/sh

DAY=6 # 超过天数后重启

cd "$(dirname "$(readlink -f "$0")")" || exit 1
FILE='last-reboot.log'

datetime() {
	TZ='Asia/Shanghai' date '+%Y-%m-%d %H:%M:%S' > "$FILE"
	echo >> "$FILE"
}

CHECK="/var/run/reboot-required"
if [ -e "$CHECK" ]; then
	cat "$CHECK"

	sudo apt clean

	datetime
	cat "${CHECK}.pkgs" >> "$FILE"

	sudo reboot
fi

UPSEC=$(awk '{print $1}' /proc/uptime)
UPDAY=$(echo "${UPSEC}/86400" | bc)

if [ "$UPDAY" -ge "$DAY" ]; then
	datetime
	echo "uptime over $UPDAY days (${UPTIME} sec)" >> "$FILE"
	sudo reboot
fi
