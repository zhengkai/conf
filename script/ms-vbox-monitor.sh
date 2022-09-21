#!/bin/bash

CHECK_TEXT='Expiration date: December 13, 2022'

TMP_FILE='/tmp/ms-vbox.html'

# 傻逼微软的 win10 镜像老是过期了才更新，着急用，写个脚本监视新镜像出来没

curl -s 'https://developer.microsoft.com/en-us/windows/downloads/virtual-machines/' -o "$TMP_FILE" || exit 1
if [ ! -s "$TMP_FILE" ]; then
	exit 1
fi

grep 'Expiration date:' "$TMP_FILE" || exit

cd "$(dirname "$(readlink -f "$0")")" || exit 1

TZ='Asia/Shanghai' date '+%Y-%m-%d %H:%M:%S'

FIND=$(grep -F "$CHECK_TEXT" "$TMP_FILE")
if [ -z "$FIND" ]; then
	XDG_RUNTIME_DIR=/run/user/$(id -u) notify-send 'ms vbox found'
	for _ in {0..10}; do
		aplay ./mixkit-sci-fi-reject-notification-896.wav
	done
else
	echo 'no change'
fi
