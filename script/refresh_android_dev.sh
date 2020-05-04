#!/bin/bash
date --date='TZ="Asia/Shanghai" now' +'%Y-%m-%d %H:%M:%S' >> /tmp/refresh_android.txt
/www/Android/Sdk/platform-tools/adb shell input text "rr"
