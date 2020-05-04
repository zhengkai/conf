#!/bin/bash

HASH=`git rev-parse --short HEAD 2>/dev/null || :`
if [ -z "$HASH" ]; then
	exit 1
fi

TAG=`git describe --exact-match "$HASH" 2>/dev/null | head -n 1`
if [ -n "$TAG" ]; then
	HASH="$TAG"
fi

ST=`git status -s -u | head -n 1`
if [ -n "$ST" ]; then
	HASH="${HASH}-dirty"
fi

BRANCH=`git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1/"`
if [[ "$BRANCH" == *"("* ]]; then
	BRANCH=''
else
	BRANCH="${BRANCH}:"
fi

echo "${BRANCH}${HASH}"
