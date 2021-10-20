#!/bin/bash

SAVE_PATH="/tmp"

if [ -z "$1" ]; then
	>&2 echo 'no url'
	exit 1
fi

ODIN="/odin/share/youtube"
PURE="/youtube"
if [ -w "$ODIN" ]; then
	SAVE_PATH="$ODIN"
elif [ -w "$PURE" ]; then
	SAVE_PATH="$PURE"
fi

youtube-dl -f bestvideo+bestaudio \
	--merge-output-format mkv \
	-o "${SAVE_PATH}/%(title)s-%(id)s.%(ext)s" \
	"$@"
