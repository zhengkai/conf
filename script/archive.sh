#!/bin/bash

DATE=$(TZ="Asia/Shanghai" date "+%Y%m")
echo "$DATE"

function archive() {
	DST="$2/${DATE}"
	# mkdir -p "$DST"
	# mv "${SRC}/"* "${DST}/"
	cd "$1" || exit 1
	find . -type d -exec mkdir -p {} "${DST}"/{} \;
	find . -type f -exec mv {} "${DST}"/{} \;
}

archive "/home/zhengkai/Pictures" "/mnt/sdb/pic"
# archive "/share" "/mnt/sdb/share"
