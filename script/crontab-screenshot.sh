#!/bin/bash -ex

# require: imagemagick
# combine gif: convert -delay 10 *.png -resize 200x113 -loop 0 1.gif

# 30	10,16	* * * ~/conf/script/crontab-screenshot.sh >/dev/null 2>&1

cd "$(dirname "$(readlink -f "$0")")" || exit 1

TMP=$(./screenshot.sh)
if [ -z "$TMP" ]; then
	exit
fi

FILE="${HOME}/Pictures/screenshot/$(date "+%Y-%m/%d-%H%M%S").png"
mkdir -p "$(dirname "$FILE")"
mv "$TMP" "$FILE"
