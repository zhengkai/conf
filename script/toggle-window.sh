#!/bin/bash

TOGGLE_WIN_FILE="${HOME}/.config/toggle-win"
ID=$(cat "$TOGGLE_WIN_FILE" 2>/dev/null || :)

if [ -n "$ID" ]; then
	xwininfo -id "$ID" >/dev/null || ID=""
fi

if [ -z "$ID" ]; then
	KITTY_DISABLE_WAYLAND=1 GLFW_IM_MODULE=ibus /usr/local/bin/kitty --start-as=fullscreen -o "shell=/home/zhengkai/conf/script/tmux-tilda.sh" &
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
