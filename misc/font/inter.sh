#!/bin/bash -ex

VER="3.13"

TAREGT="/usr/share/fonts/opentype/inter"
mkdir -p "$TARGET"

TMP="/tmp/inter-font"
mkdir -p "$TMP"
cd "$TMP"

FILE="${TARGET}/inter.zip"

# curl "https://github.com/rsms/inter/releases/download/v${VER}/Inter-${VER}.zip" -o "$FILE"

# unzip "$FILE"

echo "$VER" "$FILE"

cd "${TARGET}/Inter Desktop"

mv ./*.otf "$TAREGT"
