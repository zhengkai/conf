#!/bin/bash

DATE=$(TZ="Asia/Shanghai" date "+%Y%m")

function archive() {

	DST="${2%/}/${DATE}"

	echo
	echo "$1 -> $DST"
	echo

	cd "$1" || exit 1
	cd "$2" || exit 1

	find "$1" -type f -name "Thumbs.db*" -delete
	rsync --partial -vzrtopg --remove-source-files "${1%/}/" "$DST" || exit 1
	find "$1" -mindepth 1 -type d -empty -delete
}

archive "${HOME}/Pictures/Screenshots" "/mnt/sdb/pic"
archive "/share" "/mnt/sdb/share"
