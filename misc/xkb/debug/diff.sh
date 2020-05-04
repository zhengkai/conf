#!/bin/bash

cd $(dirname `readlink -f $0`)

xkbcomp $DISPLAY xkb-b.dump

colordiff -u xkb-a.dump xkb-b.dump
