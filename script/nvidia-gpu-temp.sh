#!/bin/bash

T=$(nvidia-smi -q --display=TEMPERATURE | grep 'GPU Current Temp' | cut -d':' -f2 | grep -o -P '\d+')

echo "$T"
if [ "$T" -gt 80 ] || [ "$T" -lt 20 ]; then
	~/hide/mailgun/gpu-alert.sh "$T"
	sudo shutdown -P 0
fi
