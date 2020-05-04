#!/bin/bash

cd $(dirname `readlink -f $0`)

FILE="config/${1}.nordvpn.com.udp.ovpn"

if [ ! -f "$FILE" ]; then
	>&2 echo no file: $FILE
	exit 1
fi

echo config $1

cp "$FILE" openvpn.txt
echo >> openvpn.txt
cat addon.txt >> openvpn.txt

echo >> openvpn.txt
echo "# $1" >> openvpn.txt
