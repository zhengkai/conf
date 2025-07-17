#!/bin/bash

TOGGLE_WIN_FILE="${HOME}/.config/toggle-win"
ID=$(< "$TOGGLE_WIN_FILE")

if [ -n "$ID" ]; then
	xwininfo -id "$ID" >/dev/null || ID=""
fi

if [ -z "$ID" ]; then
	# WEZTERM_FULLSCREEN=1 flatpak run org.wezfurlong.wezterm &
	# WEZTERM_FULLSCREEN=1 wezterm start &
	WEZTERM_FULLSCREEN=1 /usr/bin/wezterm start --always-new-process &
	PID="$!"
	for _ in {1..30}; do
		ID=$(xdotool search --pid "$PID" || :)
		if [ -n "$ID" ]; then
			break
		fi
		sleep 0.2
	done
	if [ -z "$ID" ]; then
		exit
	fi
	echo "$ID" | tail -n 1 > "$TOGGLE_WIN_FILE"
	xdotool windowmove "$ID" 0 0
	exit
fi

if xwininfo -id "$ID" -all | grep -q Hidden; then
	xdotool windowactivate "$ID"
else
	xdotool windowminimize "$ID"
fi
