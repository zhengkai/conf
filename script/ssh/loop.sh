#!/bin/bash

PORT=57777

cd "$(dirname "$(readlink -f "$0")")" || exit 1

if [ ! -f "config" ]; then
	cp config.example config
fi

while true; do
	TZ='Asia/Shanghai' date '+%Y-%m-%d %H:%M:%S'
    ssh -F config -N -D "${PORT}" tt
    sleep 3
done
