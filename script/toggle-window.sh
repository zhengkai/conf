#!/bin/bash

TOGGLE_WIN_FILE="${HOME}/.config/toggle-win"
ID=$(cat "$TOGGLE_WIN_FILE")

xwininfo -id "$ID" >/dev/null || ID=""

if [ -z "$ID" ]; then
	/usr/local/src/alacritty/target/release/alacritty &
	PID="$!"
	while [ -z "$ID" ]
	do
		ID=$(xdotool search --pid "$PID")
		sleep 1
	done
	echo "$ID" > "$TOGGLE_WIN_FILE"
	exit
fi

if xwininfo -id "$ID" -all | grep -q Hidden; then
	xdotool windowactivate "$ID"
else
	xdotool windowminimize "$ID"
fi
