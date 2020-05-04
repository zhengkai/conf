#!/bin/bash -ex

DIR="${1%/}"

if [ -z "$DIR" ]; then
	echo "input target dir"
	exit 1
fi

if [ ! -d "$DIR" ]; then
	echo "no dir $1"
	exit 1
fi

if [ ! -w "$DIR" ]; then
	echo "can not write dir $1"
	exit 1
fi

if [ ! -O "$DIR" ]; then
	echo "no own dir $1"
	exit 1
fi

cd $(dirname `readlink -f $0`)
cd ../../..

SOURCE=`pwd`

rsync --partial -vzrtopg \
	--exclude='/.cache/' \
	--exclude='/.config/google-chrome/' \
	--exclude='.git' \
	--exclude='*.iso' \
	--exclude='/.npm/' \
	--exclude='/Downloads/' \
	"${SOURCE}/" \
	"$DIR"
