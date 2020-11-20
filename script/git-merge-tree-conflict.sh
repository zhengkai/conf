#!/bin/bash

FILE=""
FOUND=""

MATCH_BEGIN="^(added|changed) in "
MATCH_CONFLICT="^\+<<<<<<< \.our"
MATCH_CONFLICT_SIDE="^\+======="
MATCH_CONFLICT_END="^\+>>>>>>> \.their"

# 处理 git merge-tree 的输出，挑出冲突的文件

ADD=0
SUB=0

START="0"

while read -r LINE
do

	if [[ "$LINE" =~ $MATCH_BEGIN ]]; then

		if [ -n "$FILE" ] && [ -n "$FOUND" ]; then
			echo "$FILE" "$FOUND"
		fi

		FILE=""
		ADD=0
		SUB=0
		continue
	fi

	if [ -z "$FILE" ]; then
		FILE="${LINE:55}"
		FOUND=""
		continue
	fi

	if [[ "$LINE" =~ $MATCH_CONFLICT ]]; then
		START="1"
		continue
	fi

	if [[ "$LINE" =~ $MATCH_CONFLICT_SIDE ]]; then
		START="2"
		continue
	fi

	if [[ "$LINE" =~ $MATCH_CONFLICT_END ]]; then
		START="0"
		if [[ "$ADD" -gt 0 ]] && [[ "$SUB" -gt 0 ]]; then
			FOUND="${ADD}+${SUB}"
		fi
		continue
	fi

	if [ "$START" == "1" ]; then
		((ADD++))
		continue
	fi
	if [ "$START" == "2" ]; then
		((SUB++))
		continue
	fi

done < /dev/stdin

if [ -n "$FILE" ] && [ -n "$FOUND" ]; then
	echo "$FILE" "$FOUND"
fi
