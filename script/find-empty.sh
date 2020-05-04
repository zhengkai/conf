#!/bin/bash

# 超过 30 分钟没有改动的目录
#
# 为了安全就不在结尾加 -delete 了

find . -type d -mmin +30 -empty -print
