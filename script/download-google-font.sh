#!/bin/bash

# 给定 Google Webfont 字体名，下载相应 css/woff2 文件用于本地自架
#
# 如
# ./download-google-font.sh "Noto Sans SC"

NAME="${1:-Kode Mono}"

NAME="${NAME//+/ }"
NAMELOW="${NAME,,}"
NAMELOW="${NAMELOW// /-}"

echo "download $NAME"

# if [ ! -e "$NAMELOW.zip" ]; then
# 	curl -s -L "https://fonts.google.com/download?family=${NAME// /+}" -o "$NAMELOW.zip"
# fi

CSS="$NAMELOW.css"
if [ ! -e "$CSS" ]; then
	curl -s -L "https://fonts.googleapis.com/css2?family=${NAME// /+}" -o "$CSS"
fi

mkdir -p font

CSS_FINAL="font/$NAMELOW.css"
{
	echo "/* $NAME */"
	echo "/* https://fonts.google.com/specimen/${NAME// /+} */"
	echo "/* download at $(date "+%Y-%m-%d %H:%M:%S") */"
	echo
	cat "$CSS"
} > "$CSS_FINAL"

tr -d '\n' < "$CSS" | grep -oP "(/\*[^\}]+\})" | while read -r BLOCK ; do
	VARIANT=$(echo "$BLOCK" | grep -oP "(/\*\s*\K.*?(?=\s*\*/))")
	URL=$(echo "$BLOCK" | grep -oP "url\(\K[^\)]*")
	FILE="${NAMELOW}-${VARIANT//[^a-zA-Z0-9\-]/}.woff2"
	echo "$FILE"
	echo "$URL"
	echo "$BLOCK"
	curl -s "$URL" -o "font/$FILE"
	sed -i "s|url($URL)|url($FILE)|g" "$CSS_FINAL"
done

cat "$CSS_FINAL"
