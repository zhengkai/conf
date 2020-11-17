#!/bin/bash

TOGGLE_WIN_FILE="${HOME}/.config/toggle-win"
ID=$(cat "$TOGGLE_WIN_FILE" 2>/dev/null || :)

if [ -n "$ID" ]; then
	xwininfo -id "$ID" >/dev/null || ID=""
fi

if [ -z "$ID" ]; then
	/usr/local/src/kitty/kitty/launcher/kitty --start-as=fullscreen &
	PID="$!"
	while [ -z "$ID" ]
	do
		ID=$(xdotool search --pid "$PID" || :)
		sleep 1
	done
	echo "$ID" > "$TOGGLE_WIN_FILE"
	xdotool windowmove "$ID" 0 0
	exit
fi

if xwininfo -id "$ID" -all | grep -q Hidden; then
	xdotool windowactivate "$ID"
else
	xdotool windowminimize "$ID"
fi
