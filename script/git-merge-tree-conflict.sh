#!/bin/bash

FILE=""
FOUND=""

MATCH_BEGIN="^(added|changed) in "
MATCH_CONFLICT="^\+<<<<<<< \.our"

# 处理 git merge-tree 的输出，挑出冲突的文件

while read -r LINE
do

	if [[ "$LINE" =~ $MATCH_BEGIN ]]; then
		FILE=""
		continue
	fi
	if [ -z "$FILE" ]; then
		FILE="${LINE:55}"
		FOUND=""
		continue
	fi
	if [ -n "$FOUND" ]; then
		continue
	fi

	if [[ "$LINE" =~ $MATCH_CONFLICT ]]; then
		FOUND="1"
		echo "$FILE"
		continue
	fi

done < /dev/stdin
