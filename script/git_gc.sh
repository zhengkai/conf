#!/bin/bash

pathList=`locate '.git' | grep -e '\.git$'`

for s in ${pathList[@]}
do

	if [ ! -d "$s" ]; then
		continue
	fi

	echo
	date --date='TZ="Asia/Shanghai" now' +'%Y-%m-%d %H:%M:%S'
	echo $s
	echo
	cd $s || continue
	git fetch
	git gc
done
