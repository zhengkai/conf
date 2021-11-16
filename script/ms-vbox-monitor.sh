#!/bin/bash

TMP_FILE='/tmp/ms-vbox.html'

# 傻逼微软的 win10 镜像老是过期了才更新，着急用，写个脚本监视新镜像出来没

curl -s 'https://developer.microsoft.com/en-us/windows/downloads/virtual-machines/' -o "$TMP_FILE" || exit 1
if [ ! -s "$TMP_FILE" ]; then
	exit 1
fi

cd "$(dirname "$(readlink -f "$0")")" || exit 1

FIND=$(grep -F 'This VM will expire on 11/14/21.' "$TMP_FILE")
if [ -z "$FIND" ]; then
	notify-send 'ms vbox found'
	for _ in {0..10}; do
		aplay ./mixkit-sci-fi-reject-notification-896.wav
	done
else
	echo 'no change'
fi
