#!/bin/bash -e

DIR=$(dirname `readlink -f $0`)
"$DIR/fpm-cut-log.sh" 2>&1 || : &

NGINX='/var/run/nginx.pid'
if [ ! -e "$NGINX" ]; then
	>&2 echo "no nginx pid file: $NGINX"
	exit
fi

cd /log || exit 1

DATE=`date --date='TZ="Asia/Shanghai" now' +'%Y%m/%d'`

readarray FILE < <( find . -type f \( -name 'access.log' -o -name 'error.log' \) -not -empty )

echo ${#FILE[@]}

if [ -z "$FILE" ]; then
	>&2 echo 'no log found, exit'
	exit
fi

CHANGE=''
for L in "${FILE[@]}"; do
	L=`echo "$L" | tr -d '\n'`

	if [ ! -f "$L" ]; then
		>&2 echo "unknown problem file $L, skip"
		continue
	fi

	D=`dirname "$L"`
	F=`basename "$L"`

	NEW="$D/$DATE-$F"
	if [ -e "$NEW" ]; then
		>&2 echo "$L skip"
		continue
	fi

	NEWD=`dirname "$NEW"`

	if [ ! -e "$NEWD" ]; then
		mkdir -p "$NEWD"
	fi
	if [ ! -w "$NEWD" ] || [ ! -d "$NEWD" ]; then
		continue
	fi

	echo "$L -> $NEW"
	mv "$L" "$NEW"
	CHANGE='Y'
done

if [ -n "$CHANGE" ]; then
	sudo kill -USR1 `cat "$NGINX"`
fi
