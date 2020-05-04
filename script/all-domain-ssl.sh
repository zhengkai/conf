#!/bin/bash

DOMAIN='
soulogic.com
time.sh
9farm.com
ruin.one
ruinone.com
'

TIME=`date '+%s'`

if [ "$TIME" -lt 1535342908 ]; then
	>&2 echo get time error
	exit 1
fi

TIME=$((TIME+86400*15)) # 过期时间 15 天以内

cd $(dirname `readlink -f $0`)

DOMAIN=($DOMAIN)
for D in "${DOMAIN[@]}"
do
	printf "%20s ... " $D
	T=`./check-ssl-expire.sh "$D" | head -n 1`
	EXPIRE=`date -d "@$T" '+%Y-%m-%d %H:%M:%S'`
	if [ "$T" -lt $TIME ]; then
		TITLE="SSL for $D expired"
		CONTENT="expired in $EXPIRE // ~/conf/script/all-domain-ssl.sh"
		echo FAIL $EXPIRE
		>&2 echo $TITLE
		>&2 echo $CONTENT
		~/hide/mailgun/alert.sh "$TITLE" "$CONTENT"
		exit 1
	else
		echo OK $EXPIRE
	fi
done
