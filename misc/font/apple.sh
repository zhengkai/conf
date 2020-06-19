#!/bin/bash -e

DIR="/tmp/apple-font"

mkdir -p "$DIR"

declare -a FONT=(
	"SF-Font-Pro,SanFranciscoPro"
	"SF-Font-Compact,SanFranciscoCompact"
	"SF-Mono,SFMonoFonts"
	"NY-Font,NYFonts"
)

TARGET="/usr/share/fonts/opentype/apple"
sudo mkdir -p "$TARGET"

sudo apt install -y p7zip-full p7zip-rar

for ROW in "${FONT[@]}"
do

	IFS=', ' read -r -a row <<< "$ROW"

	NAME="${row[0]}"
	FILE="${NAME}.dmg"

	SUB_DIR="${row[1]}"

	cd "$DIR"

	wget "https://developer.apple.com/design/downloads/${NAME}.dmg"

	7z x "$FILE"

	cd "$SUB_DIR"

	7z x ./*.pkg

	7z x "Payload~"

	cd Library/Fonts

	sudo mv ./*.otf "$TARGET"

done
