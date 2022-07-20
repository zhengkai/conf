#!/bin/bash

if [ -z "$1" ] || [ ! -d "$1" ]; then
	>&2 echo input an path for git pull
	exit 1
fi

cd "$1" || exit 1

if [ -n "$(git status -s 2>/dev/null)" ]; then
	exit
fi

BRANCH=$(git branch --show-current)
if [ -z "$BRANCH" ]; then
	exit
fi

git fetch

if git merge-base --is-ancestor "$BRANCH" "origin/${BRANCH}"; then
	git pull
	git submodule update --init --recursive
fi

git gc --auto
