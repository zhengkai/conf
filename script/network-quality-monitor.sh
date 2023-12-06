#!/bin/bash

# 指定目标主机
target="${1:-registry.npmjs.org}"

cd "$(dirname "$(readlink -f "$0")")" || exit 1

while :; do
	ping -c 1 "$target" > /dev/null 2>&1
	#shellcheck disable=SC2181
	if [ $? -eq 0 ]; then
		break
	fi
	sleep 3
done

echo "start montage $target"

# 初始化计数器
count=0
total=0

while :; do
	((total++))
	ping -c 1 "$target" > /dev/null 2>&1
	#shellcheck disable=SC2181
	if [ $? -ne 0 ]; then
		((count++))
		DATE="$(TZ='Asia/Shanghai' date '+%Y-%m-%d %H:%M:%S')"
		echo "$DATE fail, total count $total"
	else
		count=0
	fi

	if [ $count -eq 3 ]; then
		MSG="网络异常，连续三次出现 ping $target 失败"
		XDG_RUNTIME_DIR=/run/user/$(id -u) notify-send "$MSG"
		echo "$MSG"
		sleep 3600
		count=0
	fi

	sleep 1
done
