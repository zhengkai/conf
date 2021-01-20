#!/bin/bash

if [ -z "$1" ]; then
	>&2 echo 'no url'
	exit 1
fi

SAVE_PATH='/youtube'
ODIN='/odin/share/youtube'
if [ -d "$ODIN" ]; then
	SAVE_PATH="$ODIN"
fi

if [ ! -d "$SAVE_PATH" ]; then
	>&2 echo no dir $SAVE_PATH
	exit 1
fi

cd "$SAVE_PATH" || exit 1

set -x
/usr/local/bin/youtube-dl -f bestvideo+bestaudio \
	--merge-output-format mkv \
	--write-sub --all-subs --embed-subs \
	-o "${SAVE_PATH}/%(title)s-%(id)s.%(ext)s" \
	"$@"
