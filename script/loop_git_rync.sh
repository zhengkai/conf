#!/bin/bash

# 30	3,17	* * * ~/conf/script/loop_git_rync.sh >/dev/null 2>&1

list_fetch=$HOME"/git/fetch";
list_push=$HOME"/git/push";

if [ -e $list_fetch ]; then

	list=(`cat $list_fetch`)

	for dir in ${list[@]}; do

		echo
		echo $dir

		if [ ! -d $dir ]; then
			echo -e '\tno dir '$dir
			continue
		fi

		if [ ! git rev-parse --git-dir > /dev/null 2>&1 ]; then
			echo -e '\tnot a git repository'
			continue
		fi

		cd $dir
		git fetch
		git gc
		echo -e '\tover'
	done

else

	echo
	echo 'fetch file "'$list_fetch'" not exists'
	exit 1
fi

if [ -e $list_push ]; then

	list=(`cat $list_push`)

	for dir in ${list[@]}; do

		echo
		echo $dir

		if [ ! -d $dir ]; then
			echo -e '\tno dir '$dir
			continue
		fi

		if [ ! git rev-parse --git-dir > /dev/null 2>&1 ]; then
			echo -e '\tnot a git repository'
			continue
		fi

		cd $dir
		git push
		git gc
		echo -e '\tover'
	done

else

	echo
	echo 'push file "'$list_push'" not exists'
	exit 1
fi
