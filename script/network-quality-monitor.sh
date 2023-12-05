#!/bin/bash

# 初始化计数器
count=0
total=0

# 指定目标主机
target="${1:-registry.npmjs.org}"

while :; do
  # 使用ping命令测试网络连接，只发送一个包
  ((total++))
  ping -c 1 "$target" > /dev/null 2>&1
  #shellcheck disable=SC2181
  if [ $? -ne 0 ]; then
    ((count++))
	DATE="$(TZ='Asia/Shanghai' date '+%Y-%m-%d %H:%M:%S')"
	echo "$DATE fail, total count $total"
  else
    count=0 # 如果ping成功，则重置计数器
  fi

  # 如果连续三次PING失败
  if [ $count -eq 3 ]; then
    echo "Alarm: $target not reachable 3 times in a row."
  fi

  # 等待1秒钟再进行下一次ping
  sleep 1
done
