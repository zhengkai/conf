#!/bin/sh

CHECK="/var/run/reboot-required"
if [ ! -e "$CHECK" ]; then
	exit
fi
cat "$CHECK"

DIR=`readlink -f "$0"` && DIR=`dirname "$DIR"` && cd "$DIR" || exit 1

FILE='last-reboot.log'

TZ='Asia/Shanghai' date '+%Y-%m-%d %H:%M:%S' > "$FILE"
echo >> "$FILE"
cat /var/run/reboot-required.pkgs >> "$FILE"

sudo reboot
