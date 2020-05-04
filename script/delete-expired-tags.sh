#!/bin/bash

# 删除某个时间之前的所有 tag
#
# 由于太危险，用的时候先把最后两行的 echo 去了

now=`date +'%s' --date='60 days ago'`

cd $(dirname `readlink -f $0`)

for line in `git ls-remote --tags origin | grep -v '\^{}$'`; do

	tag=`echo "$line" | grep 'refs/tags/'`
	tag=${tag:10}
	if [ -z "$tag" ]; then
		continue
	fi

	ts=`git log -1 --format='format:%at' "$tag"`

	echo
	echo "[ $tag ] "`date +'%Y-%m-%d %H:%M:%S' -d "@$ts"`
	echo

	if [ -z "$ts" ]; then
		continue
	fi

	if [ "$ts" -gt "$now" ]; then
		continue
	fi

	echo git push --delete origin "$tag"
	echo git tag --delete "$tag"

done
