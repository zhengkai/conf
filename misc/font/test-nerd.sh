#!/bin/bash

# 显示一些 Nerd Font 图标
echo -e "\uf489  Terminal"
echo -e "\ue795  Folder"
echo -e "\uf7c2  GitHub"
echo -e "\uf121  Code"
echo -e "\uf1e6  HTML"
echo -e "\uf3df  JavaScript"
echo -e "\uf41e  Docker"
echo -e "\uf313  Kubernetes"

# 定义 ANSI 转义序列
RESET="\033[0m"       # 重置所有样式

# 定义样式数组
STYLES=(
    "\033[1m"        # 粗体
    "\033[2m"        # 暗淡
    "\033[3m"        # 斜体
    "\033[4m"        # 下划线
    "\033[5m"        # 闪烁
    "\033[7m"        # 反色
    "\033[8m"        # 隐藏
)

# 定义颜色数组
COLORS=(
    "\033[31m"       # 红色
    "\033[32m"       # 绿色
    "\033[33m"       # 黄色
    "\033[34m"       # 蓝色
    "\033[35m"       # 洋红色
    "\033[36m"       # 青色
    "\033[37m"       # 白色
)

# 定义样式名称数组
STYLE_NAMES=(
    "Bold"
    "Dim"
    "Italic"
    "Underline"
    "Blink"
    "Reverse"
    "Hidden"
)

# 定义颜色名称数组
COLOR_NAMES=(
    "Red"
    "Green"
    "Yellow"
    "Blue"
    "Magenta"
    "Cyan"
    "White"
)

# 测试文本
TEXT="Ultra Suffix == != >= [TODO]  \\ #{ -> ~@ |> 0x12 ~!@#$%^&* {} [] () I1l O0o"

# 打印标题
echo -e "=== Terminal Font Test ===\n"

# 测试样式
echo -e "=== Styles ==="
for i in "${!STYLES[@]}"; do
    echo -e "${STYLE_NAMES[$i]}: ${STYLES[$i]}${TEXT}${RESET}"
done

# 测试颜色
echo -e "\n=== Colors ==="
for i in "${!COLORS[@]}"; do
    echo -e "${COLOR_NAMES[$i]}: ${COLORS[$i]}${TEXT}${RESET}"
done

# 测试组合样式
echo -e "\n=== Combined Styles ==="
echo -e "Bold + Italic: ${STYLES[0]}${STYLES[2]}${TEXT}${RESET}"
echo -e "Bold + Underline: ${STYLES[0]}${STYLES[3]}${TEXT}${RESET}"
echo -e "Italic + Red: ${STYLES[2]}${COLORS[0]}${TEXT}${RESET}"
echo -e "Bold + Underline + Blue: ${STYLES[0]}${STYLES[3]}${COLORS[3]}${TEXT}${RESET}"
echo -e "Reverse + Green: ${STYLES[5]}${COLORS[1]}${TEXT}${RESET}"
