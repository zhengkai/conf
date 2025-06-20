#!/bin/bash

TOGGLE_WIN_FILE="${HOME}/.config/toggle-win"
ID=$(cat "$TOGGLE_WIN_FILE" 2>/dev/null || :)

if [ -n "$ID" ]; then
	xwininfo -id "$ID" >/dev/null || ID=""
fi

if [ -z "$ID" ]; then
	WEZTERM_FULLSCREEN=1 wezterm &
	PID="$!"
	while true; do
		ID=$(xdotool search --pid "$PID" || :)
		if [ -n "$ID" ]; then
			break
		fi
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
