#!/bin/bash

TZ='Asia/Shanghai' date '+%Y-%m-%d %H:%M:%S' >> /log/clean-autojump.log

exit

DIR=${1:-/www/}

# 清理 autojump 数据里的特定目录，要从 / 起始
#
# 填 all 是全删

cd ~/.local/share/autojump || exit 1
# cd /tmp/autojump || exit 1

if [ "$DIR" == "all" ]; then
	rm autojump.txt || :
	rm autojump.txt.bak || :
	exit
fi

echo "clean dir $DIR in autojump"

PATTERN=$(echo "$DIR" | sed 's/\//\\\//g')

sed -i "/\t${PATTERN}/d" autojump.txt
