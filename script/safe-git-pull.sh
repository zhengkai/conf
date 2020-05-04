#!/bin/bash

if [ -z "$1" ]; then
	>&2 echo input an path for git pull
	exit 1
fi

cd $1 || exit 1

if [ -n "`git status -s 2>/dev/null`" ]; then
	exit
fi

LOCAL=`git rev-parse HEAD`
REMOTE=`git show-ref -s 'refs/remotes/origin/HEAD'`

if [ "$LOCAL" == "$REMOTE" ]; then
	git pull
	git submodule update --init --recursive
else
	git fetch
fi

git gc
