#!/bin/bash

cd $(dirname `readlink -f $0`)

LIST=(`ls config | grep 'us' | cut -d '.' -f 1 | grep -P "$1\d"`)

# echo list: "${LIST[*]}"

for v in "${LIST[@]}"
do

	IP=`grep 'remote ' "config/${v}.nordvpn.com.udp.ovpn" | cut -d ' ' -f 2`

	echo
	echo $v $IP

	geoiplookup "$IP"
done
