#!/bin/bash

FILE=(
	'00-header'
	'10-help-text'
	'50-motd-news'
	'80-livepatch'
	'88-esm-announce'
)
for F in "${FILE[@]}"; do
	F="/etc/update-motd.d/${F}"
	if [ -e "$F" ]; then
		sudo rm "$F"
	fi
done
