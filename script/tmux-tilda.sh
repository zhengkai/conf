#!/bin/bash

name='tilda'
window_num=6

cd "$(dirname "$(readlink -f "$0")")" || exit 1

../bin/tmu "$name" "$window_num"
