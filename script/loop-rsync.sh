#!/bin/bash

# 需要同步两个目录，如果是一次性的、时间较长、中途可能多次失败，可使用本脚本

SRC="$1"
DST="$2"
if [ -z "$SRC" ] || [ -z "$DST" ]; then
	echo "Usage: $0 <src> <dst>"
	exit 1
fi

while :; do
    start_time=$(date +%s)
	rsync --partial -vzrtopg -e ssh "$SRC" "$DST"
	end_time=$(date +%s)

    elapsed_time=$((end_time - start_time))
	if [ $elapsed_time -le 30 ]; then
        sleep 1000
	fi
	sleep 60
done
