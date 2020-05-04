#!/bin/bash

cd $(dirname `readlink -f $0`)

setxkbmap

xkbcomp $DISPLAY xkb-a.dump
