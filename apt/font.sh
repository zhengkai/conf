#! /bin/bash -e

TMP_FILE='/tmp/JetBrainsMono.zip'
TMP_DIR='/tmp/JetBrainsMono'

TARGET="/usr/local/share/fonts"
if [ -f "${TARGET}/JetBrainsMono-Regular.ttf" ]; then
	echo
	echo font JetBrains Mono installed, exit
	echo
	exit
fi

curl 'https://download.jetbrains.com/fonts/JetBrainsMono-1.0.3.zip' -o "$TMP_FILE"

mkdir -p "$TMP_DIR"
cd "$TMP_DIR"
unzip -o -j "$TMP_FILE" -d "$TMP_DIR"
sudo cp JetBrainsMono*.ttf "$TARGET"
