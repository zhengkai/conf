#!/bin/bash

LIST=$(find . -type f | sed 's/.*\.//' | grep -v '/' | sort | uniq)

echo "$LIST" | while IFS= read -r EXT; do
	SIZE=$(find . -type f -name "*.${EXT}" -exec du -ch {} +  | \tail -n 1 | awk '{print $1}')
	tabs 8
	echo -e "${EXT}\t${SIZE}"
done
