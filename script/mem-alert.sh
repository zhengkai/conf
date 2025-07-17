#!/bin/bash

BOT_SCRIPT="$0"

if [ -z "$BOT_SCRIPT" ]; then
	>&2 echo 'env BOT_SCRIPT is not set'
	exit
fi
if [ ! -x "$BOT_SCRIPT" ]; then
	>&2 echo "script $BOT_SCRIPT does not exist or is not executable"
	exit
fi

while true; do

	MEM_USED=$(free | awk '/Mem/{printf("%.0f"), $3/$2*100}')
	echo "$MEM_USED"

	if [ "$MEM_USED" -lt 80 ]; then
		sleep 60
		continue
	fi

	if [ "$MEM_USED" -ge 90 ]; then

		TOP=$(ps -eo pid,ppid,args,%mem,%cpu --sort=-%mem | head -n 5)

		export MEM_USED
		export TOP
		echo "$BOT_SCRIPT"

		sleep 3600
	fi

	sleep 5

done
