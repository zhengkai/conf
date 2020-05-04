#!/bin/bash

SAVE_PATH='/youtube'

if [ -z "$1" ]; then
	>&2 echo 'no url'
	exit 1
fi

# if [ "$HOSTNAME" == 'Freya' ]; then
#
# 	cd /tmp
# 	youtube-dl -f bestvideo+bestaudio \
# 		--merge-output-format mkv \
# 		-o "/tmp/youtube/%(title)s-%(id)s.%(ext)s" \
# 		--exec "/home/zhengkai/conf/script/youtube-mv.sh" \
# 		"$@"
# 	exit
# fi

if [ "$HOSTNAME" == 'Monk' ]; then
	ODIN="/mnt/odin/youtube"
	if [ -d "$ODIN" ]; then
		SAVE_PATH="$ODIN"
	fi
fi

if [ ! -d "$SAVE_PATH" ]; then
	>&2 echo no dir $SAVE_PATH
	exit 1
fi

cd "$SAVE_PATH"
youtube-dl -f bestvideo+bestaudio \
	--merge-output-format mkv \
	-o "${SAVE_PATH}/%(title)s-%(id)s.%(ext)s" \
	"$@"
exit
