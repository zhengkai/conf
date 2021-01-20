#!/bin/bash

DATE=$(TZ="Asia/Shanghai" date "+%Y%m")
echo "$DATE"

function archive() {
	SRC="$1"
	DST="$2/${DATE}"
	mkdir -p "$DST"
	mv "${SRC}/"* "${DST}/"
}

archive "/home/zhengkai/Pictures" "/mnt/sdb/pic"
archive "/share" "/mnt/sdb/share"
