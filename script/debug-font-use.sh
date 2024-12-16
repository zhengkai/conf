#!/bin/bash

# 检查每个字按系统顺序都实际用的哪个字体
#
# 用来验证 fonts.conf 的实际效果

CHARS=("" "中" "體" "の" "안" "😊" "م" "स्" "и")
FAMILY=("sans-serif" "serif" "monospace")

tabs 4
for F in "${FAMILY[@]}"; do
	echo
	for CHAR in "${CHARS[@]}"; do
		CODE=$(printf "%04X" "'${CHAR}'")
		printf " %s\t%6s " "$CHAR" "$CODE"
		fc-match --format="%{file} %{family}\n" "${F}:charset=${CODE}"
	done
done
