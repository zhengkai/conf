#!/bin/bash

# require: imagemagick
# combine gif: convert -delay 10 *.png -resize 200x113 -loop 0 1.gif

# 30	10,16	* * * ~/conf/script/screenshot.sh >/dev/null 2>&1

cd $(dirname `readlink -f $0`)

# sleep $[ $RANDOM * 3600 / 32767 ]

./screenshot.sh '%Y_%m/%d_%H%M%S'
