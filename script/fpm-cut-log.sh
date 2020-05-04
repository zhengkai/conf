#!/bin/bash

cd /log || exit 1
cd /var/log/php || exit 1

function move() {

	local FILE="fpm-${1}.log"

	if [ ! -s "$FILE" ]; then
		return
	fi

	local FORMAT=`TZ='Asia/Shanghai' date '+%Y%m/%d'`
	local TARGET="/log/php-fpm/${FORMAT}.${1}.log"

	local DIR=`dirname "$TARGET"`
	mkdir -p "$DIR" || exit 1

	sudo mv "$FILE" "$TARGET"
	sudo service php-fpm reload

	sudo cat "$TARGET" | gzip --best >> "${TARGET}.gz"
	sudo rm "$TARGET"
}

move 'www'
move 'error'
