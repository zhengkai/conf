#!/bin/bash

name='tilda'
window_num=6

DIR=$(readlink -f "$0") && DIR=$(dirname "$DIR") && cd "$DIR" || exit 1

../bin/tmu "$name" "$window_num"
