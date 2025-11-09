#!/bin/bash

# rename.sh - 将当前目录及子目录下的文件名转换为小写，空格和下划线替换为连字符

shopt -s globstar nullglob

# 遍历所有文件和目录，先处理深层再处理上层
find . -depth | while IFS= read -r file; do
    dir=$(dirname "$file")
    base=$(basename "$file")
    # 转小写，空格和下划线替换为 -
    newbase=$(echo "$base" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -s '-')
    if [[ "$base" != "$newbase" ]]; then
        mv -i "$file" "$dir/$newbase"
    fi
done
