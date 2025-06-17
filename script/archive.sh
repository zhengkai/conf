#!/bin/bash

DATE=$(TZ="Asia/Shanghai" date "+%Y%m")

shopt -s dotglob

function archive() {

	DST="${2%/}/${DATE}"

	if [ -d "$DST" ]; then
		return
	fi

	cd "$1" || exit 1

	find "$1" -type f -name "Thumbs.db" -delete
	if [[ -z "$(find "$1" -maxdepth 1 -mindepth 1 -print -quit)" ]]; then
		echo "no files in $1"
        return
	fi

	mkdir -p "$DST" || exit 1

	echo "archiving $1 to $DST"
	mv "${1%/}/"* "$DST"
}

# archive "${HOME}/Pictures" "/archive/pic"
archive "${HOME}/gnome/pic" "/archive/pic"
archive "${HOME}/gnome/download" "/archive/download"
archive "/share" "/archive/share"
