#!/bin/sh

TS=`dmesg | grep 'setting system clock to' | grep -o -P '\(\d{10}\)' | grep -o -P '\d+'`
echo $TS
date -d "@$TS" '+%Y-%m-%d %H:%M:%S'
