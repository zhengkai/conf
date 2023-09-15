#!/bin/bash -ex

# 30	10,16	* * * ~/conf/script/screenshot.sh >/dev/null 2>&1

FORMAT="${1:-%Y-%m-%d-%H%M%S}"

if [ -z "$DISPLAY" ]; then
	>&2 echo no desktop found
	export DISPLAY=:0
	# exit 1
fi

SAVE_DIR="${HOME}/Pictures/"
SUB_DIR=$(date "+$FORMAT")
FILENAME="${SAVE_DIR}${SUB_DIR}.png"

DIR=$(dirname "$FILENAME")
mkdir -p "$DIR"

import -window root "$FILENAME"

FILESIZE=$(ls -l "$FILENAME" | awk '{ print $5 }' | tail -1)
if [ "$FILESIZE" -lt 400 ]; then
	rm "$FILENAME"
fi
