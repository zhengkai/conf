#!/bin/bash -e

# download font from https://developer.apple.com/fonts/

DIR="/tmp/apple-font"

mkdir -p "$DIR"

declare -a FONT=(
	"SF-Pro,SFProFonts"
	"SF-Compact,SFCompactFonts"
	"SF-Mono,SFMonoFonts"
	"NY,NYFonts"
)

TARGET="/usr/share/fonts/opentype/apple"
sudo mkdir -p "$TARGET"

sudo apt install -y p7zip-full p7zip-rar

set -x
for ROW in "${FONT[@]}"
do

	IFS=', ' read -r -a row <<< "$ROW"

	NAME="${row[0]}"
	FILE="${NAME}.dmg"

	SUB_DIR="${row[1]}"

	cd "$DIR"

	curl "https://devimages-cdn.apple.com/design/resources/download/${NAME}.dmg" -o "$FILE"

	7z x "$FILE" -y

	cd "$SUB_DIR"

	7z x ./*.pkg -y

	cd "${SUB_DIR}.pkg"

	7z x "Payload"

	7z x "Payload~"

	cd Library/Fonts

	ls -al
	sudo mv ./*.otf "$TARGET"

done

sudo chmod -x /usr/share/fonts/opentype/apple/*.otf
