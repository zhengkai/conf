#!/bin/bash -x

# 第一个参数 js 项目目录，第二个参数 sum 文件
# 只在 package.json 变化的时候才 npm install

DIR="$1"
PACKAGE=$(realpath "${DIR}/package.json")
if [ ! -f "$PACKAGE" ]; then
	>&2 echo "package not found: $PACKAGE"
	exit 1
fi

if [ ! -w "$DIR" ]; then
	>&2 echo "can not write: $DIR"
	exit 1
fi

if [ -z "$2" ]; then
	>&2 echo "not sum file: $2"
	exit 1
fi
SUM_FILE=$(realpath "$2")

if [ -f "$SUM_FILE" ]; then
	if md5sum -c "$SUM_FILE"; then
		>&2 echo "no update needed: $PACKAGE"
		exit
	fi
fi

cd "$DIR" || exit 1
md5sum "$PACKAGE" > "$SUM_FILE"
npm install
