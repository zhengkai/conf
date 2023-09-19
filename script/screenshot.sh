#!/bin/bash -e

FILENAME="$1"
if [ -z "$FILENAME" ]; then
	FILENAME=$(mktemp --suffix="-$(date "+%Y%m%d-%H%M%S").png")
fi

if [ -z "$DISPLAY" ]; then
	D=$(who | grep '(:' |awk '{ print $2 }')
	if [ -z "$D" ]; then
		>&2 echo no desktop found
		exit 1
	fi
	export DISPLAY="$D"
fi

# meta 信息可以用 identify -verbose 命令查看 Properties -> comment
COMMENT="screenshot at $(date "+%Y-%m-%d %H:%M:%S") by $(whoami)"
import -set comment "$COMMENT" -window root "${FILENAME}"

FILESIZE=$(stat -c "%s" "$FILENAME")
if [ "$FILESIZE" -lt 4000 ]; then
	rm "$FILENAME"
	>&2 echo screenshot failed
	exit 1
fi
echo "$FILENAME"
