#!/bin/bash

# crontab:
#
# 15	8	* * * ~/conf/script/kill_cow.sh 2>&1 >/dev/null &

cow_pid=`pgrep -f 'cow/cow'`

if [ -z "$cow_pid" ]; then
	echo 'cow not found'
	exit
fi

echo 'cow pid: '$cow_pid

kill $cow_pid
