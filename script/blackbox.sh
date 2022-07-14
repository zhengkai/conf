#!/bin/bash

D=$(TZ="Asia/Shanghai" date "+%Y%m/%d/%H/%M")

FILE="${HOME}/.tmp/blackbox/${D}"

mkdir -p "$(dirname "$FILE")"

uptime | tee -a "$FILE"

iostat | tee -a "$FILE"

free -h | tee -a "$FILE"

echo | tee -a "$FILE"
/usr/bin/landscape-sysinfo | tee -a "$FILE"

echo | tee -a "$FILE"
top -w 160 -b -n 1 -1 | head -n 40 | tee -a "$FILE"
