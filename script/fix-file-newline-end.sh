#!/bin/bash

FILE="$1"
if [ ! -f "$FILE" ]; then
	exit
fi
if [ ! -s "$FILE" ]; then
	exit
fi
if [[ $(tail -c 1 "$FILE") == "" ]]; then
	exit
fi

echo '' >> "$FILE"
