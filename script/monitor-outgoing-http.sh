#!/bin/bash

HOST=`hostname`

case "$HOST" in
	'Monk')
		IF='enp2s0f0'
		;;
	'Tesla')
		IF='enp2s0'
		;;
	*)
		IF='eth0'
		;;
esac

echo $HOST $IF

(
    flock -x -n 200 || exit 1

	sudo tcpdump -A 'tcp port 80' -i $IF 2>/dev/null \
		| grep --line-buffered '^Host: ' \
		| stdbuf -o0 cut -b '7-' \
		| cronolog '/log/tcp/%Y.%m/%d'

) 200>/tmp/tcpdump80.lock
