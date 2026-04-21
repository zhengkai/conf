#! /usr/bin/env bash

TARGET=20000
FALLBACK=1
PREV_FILE="${HOME}/dev/hypr/prev-workspace.txt"
if [ ! -f "$PREV_FILE" ]; then
	mkdir -p "$(dirname "$PREV_FILE")"
fi

current=$(hyprctl activeworkspace -j | jq '.id')

if [ "$current" = "$TARGET" ]; then
    if [ -f "$PREV_FILE" ]; then
        prev="$(cat "$PREV_FILE")"
		# notify-send -t 1000 "prev $prev"
        hyprctl dispatch workspace "$prev"
    else
		# notify-send -t 1000 "prev fallback"
        hyprctl dispatch workspace "$FALLBACK"
    fi
	exit
fi

echo "$current" > "$PREV_FILE"
hyprctl dispatch workspace "$TARGET"
has=$(hyprctl clients -j | jq "[.[] | select(.workspace.id == $TARGET and .class == \"org.wezfurlong.wezterm\")] | length")
if [ "$has" -gt 0 ]; then
	# notify-send -t 1000 "target $TARGET $has, exit"
	exit
fi

cd "$(dirname "$(readlink -f "$0")")" || exit 1
./start-wezterm.sh &
