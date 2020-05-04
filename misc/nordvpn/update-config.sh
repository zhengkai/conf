#!/bin/bash

cd $(dirname `readlink -f $0`)

FILE=`tempfile -p nord`

wget https://downloads.nordcdn.com/configs/archives/servers/ovpn.zip -O "$FILE" || exit 1

TEST=`unzip -t "$FILE" 2>/dev/null | tail -n 1 | grep 'No errors detected in compressed data of'`
if [ -z "$TEST" ]; then
	>&2 echo 'package broken'
	rm "$FILE"
	exit 1
fi

SIZE=`stat -c "%s" "$FILE"`
if [ "$SIZE" -lt 10000000 ]; then
	>&2 echo "config too small (${SIZE})"
	rm "$FILE"
	exit 1
fi

if [ -e ./tmp-config ]; then
	rm -rf ./tmp-config
fi
mkdir -p ./tmp-config
unzip -o "$FILE" -d ./tmp-config

if [ ! -d ./tmp-config/ovpn_udp ]; then
	>&2 echo 'no udp config'
	rm "$FILE"
	exit 1
fi

rm -rf config
mv tmp-config/ovpn_udp config
rm -rf tmp-config

rm "$FILE"
