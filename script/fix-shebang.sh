#!/usr/bin/env bash

# 用法: ./fix_shebang.sh [目录]
# 默认遍历当前目录

target_dir="${1:-.}"

# 找到所有包含 #!/bin/bash 开头的文件
while IFS= read -r -d '' file; do

	if ! head -c 2 "$file" 2>/dev/null | grep -q '^#!'; then
        continue
    fi

    # 读取第一行
    first_line=$(head -n 1 "$file")

    # 只处理以 #!/bin/bash 开头的文件（允许后面带选项）
    if [[ "$first_line" =~ ^#!\s*/bin/bash(.*)$ ]]; then
        rest="${BASH_REMATCH[1]}"

        # 去掉前后空格
        rest=$(echo "$rest" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

        echo "处理文件: $file"
        echo "  原始 shebang: $first_line"

        if [[ -z "$rest" ]]; then
            # 没有任何选项，直接替换 shebang
            sed -i "1s|^#!.*/bin/bash.*|#!/usr/bin/env bash|" "$file"
            echo "  替换为: #!/usr/bin/env bash"
        else
            # 有选项，比如 -e, -x, -ex, -xe, -eux, -euo pipefail 等
            # 替换第一行为 #!/usr/bin/env bash
            # 并在第二行插入 set <options>

            # 构造 set 行
            set_line="set $rest"

            # 先替换第一行
            sed -i "1s|^#!.*/bin/bash.*|#!/usr/bin/env bash|" "$file"

            # 检查第二行是否已经是相同的 set 行（避免重复插入）
            second_line=$(sed -n '2p' "$file")
            if [[ "$second_line" != "$set_line" ]]; then
                sed -i "1a\\$set_line" "$file"
                echo "  替换为: #!/usr/bin/env bash"
                echo "  新增行: $set_line"
            else
                echo "  替换为: #!/usr/bin/env bash"
                echo "  set 行已存在，跳过插入"
            fi
        fi
    fi
done < <(find "$target_dir" -type f -print0)

echo ""
echo "完成！"
