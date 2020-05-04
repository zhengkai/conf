#!/bin/bash

cd $(dirname `readlink -f $0`)

if [ -z "$1" ]; then
	>&2 echo input region
	exit 1
fi

LIST=(`ls config | cut -d '.' -f 1 | grep -P "$1\d"`)

echo list: "${LIST[*]}"

CONFIG=${LIST[$RANDOM % ${#LIST[@]} ]}

./make.sh "$CONFIG"
