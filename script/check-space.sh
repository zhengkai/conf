#!/bin/bash

# 指定目录和最小空间阈值（单位为MB）
DIR="${1:-/}"
MIN_SPACE=${2:-10000}

# 使用 df 命令获取剩余空间，并使用 awk 提取需要的列
SPACE=$(df -m "$DIR" | awk 'NR==2 {print $4}')

# 检查剩余空间是否低于阈值
if [ "$SPACE" -le "$MIN_SPACE" ]; then
	printf "space low: dir %s with %'.f MB\n" "$DIR" "$SPACE" 1>&2
	exit 1
fi

printf "space ok: dir %s with %'.f MB\n" "$DIR" "$SPACE"
exit 0
