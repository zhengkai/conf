#!/bin/bash

VER="7.0"

URL="https://github.com/subframe7536/maple-font/releases/download/v${VER}/MapleMonoNormalNL-NF-CN-unhinted.zip"

FILE="maple-mono-${VER}.zip"

cd /usr/local/src || exit 1

if [ ! -f "$FILE" ]; then
	wget "$URL" -O "$FILE"
fi

mkdir -p /tmp/maple-mono
unzip -o "$FILE" -d /tmp/maple-mono

sudo mv /tmp/maple-mono/MapleMono*.ttf /usr/local/share/fonts
