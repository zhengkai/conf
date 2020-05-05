#!/bin/sh

CHECK="/var/run/reboot-required"
if [ ! -e "$CHECK" ]; then
	exit
fi
cat "$CHECK"

cd "$(dirname "$(readlink -f "$0")")" || exit 1

FILE='last-reboot.log'

TZ='Asia/Shanghai' date '+%Y-%m-%d %H:%M:%S' > "$FILE"
echo >> "$FILE"
cat /var/run/reboot-required.pkgs >> "$FILE"

sudo reboot
