#!/bin/bash

DOMAIN="asia1.ethermine.org"

FILE="${DOMAIN}.txt"
FILE_FULL="${DOMAIN}_full.txt"

host "$DOMAIN" | grep -P -o 'has address \d+\.\d+\.\d+\.\d+$' | awk '{print$3}' > "$FILE_FULL"

if [ -f "$FILE" ]; then
	exit
fi

IP=`head -n 1 "$FILE"`

MATCH=`grep "$IP" "$FILE_FULL"`
if [ -z "$MATCH" ]; then
	echo '当前不匹配'
fi
