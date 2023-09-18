#!/bin/sh

# 开机时间

TS=$(sudo dmesg | grep 'setting system clock to' | grep -o -P '\(\d{10}\)' | grep -o -P '\d+')
echo "$TS"
date -d "@${TS}" '+%Y-%m-%d %H:%M:%S'
