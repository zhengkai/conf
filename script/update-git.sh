#!/bin/bash

# 扫描默认 ~/.git_update 或者其他文件指定的目录列表，如果 git 目录存在则更新

if [ -n "$1" ]; then
	LIST_FILE=$1
else
	LIST_FILE=$HOME'/.git_update'
fi

if [ ! -r $LIST_FILE ]; then
	echo 'no list file '$LIST_FILE
	exit 1
fi

readarray GIT_LIST < $LIST_FILE

for GIT_PATH in "${GIT_LIST[@]}"; do

	echo
	echo '    '$GIT_PATH
	echo

	if [ ! -d $GIT_PATH ]; then
		echo 'skip '$GIT_PATH
		continue
	fi

	cd $GIT_PATH 2>/dev/null || continue
	git fetch --all 2>/dev/null || continue
	git fetch origin --prune 2>/dev/null || continue

	CHANGE=`git status --short 2>/dev/null | head -n 1`
	if [ -z "$CHANGE" ]; then
		git pull --rebase
		if [ -e '.gitmodules' ]; then
			git submodule update --init --recursive
		fi
	fi
done
