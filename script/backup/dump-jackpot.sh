#!/bin/bash

DIR="$(dirname "$(readlink -f "$0")")" && cd "$DIR" || exit 1

TZ="Asia/Shanghai"

NOW=$(date "+%Y-%m-%d")

TARGET="/www/zac/misc/public"
if [ ! -d "$TARGET" ]; then
	exit
fi

for i in {0..2}; do
	TS=$(date -d "$NOW" "+%s")

	START=$(( TS - i * 86400 ))
	END=$(( TS - (i - 1) * 86400 ))

	SHOW=$(date -d "@${START}" "+%Y-%m-%d")

	# echo "$i" "$TS" "$START" "$END" "$SHOW"

	FILE="${TARGET}/jackpot/jackpot-${SHOW}.txt"

	if [ $i -gt 0 ] && [ -e "$FILE" ]; then
		exit
	fi
	echo "$FILE"

	echo "SELECT * FROM jackpot_final WHERE ts_create >= $START AND ts_create < $END" | mysql > "$FILE"
	if [ -e "$FILE" ] && [ ! -s "$FILE" ]; then
		rm "$FILE"
	fi
done
