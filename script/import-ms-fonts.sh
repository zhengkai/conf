#!/bin/bash

SOURCE="${1:-/media/zhengkai/System/Windows/Fonts}"

if [ ! -d "$SOURCE" ]; then
	>&2 echo dir "$SOURCE" not found
	exit
fi

TARGET="/usr/local/share/fonts"

cd "$SOURCE" || exit 1

FONT=(
	msyhbd.ttc
	msyhl.ttc
	msyh.ttc

	msjhbd.ttc
	msjhl.ttc
	msjh.ttc

	msgothic.ttc

	malgunsl.ttf
	malgunbd.ttf
	malgun.ttf
)

# mingliub.ttc
#
# deng.ttf
# dengb.ttf
# dengl.ttf

for file in "${FONT[@]}"
do
	if [ ! -f "$file" ]; then
		echo "font $file not found"
		continue
	fi
	echo "$file"
	sudo cp "$file" "$TARGET"
done

cd "$TARGET" || exit 1
sudo chmod -x ./*

echo
ls -al
