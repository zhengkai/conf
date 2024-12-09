#!/bin/bash

for DIR in $(sudo ls -d /tmp/systemd-private-*); do
	NAME="${DIR:54}"
	NAME="${NAME:0:-7}"

	FILE="/etc/systemd/system/${NAME}.d/override.conf"
	if [ -e "$FILE" ]; then
		continue
	fi
	sudo mkdir -p "$(dirname "$FILE")"

	echo
	echo "$FILE"
	echo
	echo -e "[Service]\nPrivateTmp=no" | sudo tee "$FILE"

done
