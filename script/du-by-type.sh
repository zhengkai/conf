#!/bin/bash

LIST=(`find . -type f | sed 's/.*\.//' | grep -v '/' | sort | uniq`)

for EXT in "${LIST[@]}"
do
	SIZE=`find . -type f -name "*.${EXT}" -exec du -ch {} +  | \tail -n 1 | sed 's/\t.*//'`
	echo "$EXT,$SIZE"
done
