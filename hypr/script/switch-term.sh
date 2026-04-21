#! /usr/bin/env bash

TARGET=20000
FALLBACK=1
PREV_FILE="${HOME}/dev/hypr/prev-workspace"
if [ ! -f "$PREV_FILE" ]; then
	mkdir -p "$(dirname "$PREV_FILE")"
fi

current=$(hyprctl activeworkspace -j | jq '.id')

if [ "$current" = "$TARGET" ]; then
    if [ -f "$PREV_FILE" ]; then
        prev="$(cat "$PREV_FILE")"
		# notify-send -t 1000 "target prev $prev"
        hyprctl dispatch workspace "$prev"
    else
		# notify-send -t 1000 "target prev fallback"
        hyprctl dispatch workspace "$FALLBACK"
    fi
	exit
fi

echo "$current" > "$PREV_FILE"
hyprctl dispatch workspace "$TARGET"
# notify-send -t 1000 "target $TARGET"
has=$(hyprctl clients -j | jq "[.[] | select(.workspace.id == $TARGET and .class == \"org.wezfurlong.wezterm\")] | length")
if [ "$has" -gt 0 ]; then
	exit
fi

notify-send -t 1000 "new wezterm $has"
wezterm start -- /home/zhengkai/conf/script/tmux-tilda.sh
for i in $(seq 1 50); do
	has=$(hyprctl clients -j | jq "[.[] | select(.workspace.id == 20000 and .class == \"org.wezfurlong.wezterm\")] | length")
	echo "$i $has" >> /tmp/foo-1.txt
	if [ "$has" -gt 0 ]; then
		hyprctl dispatch fullscreen 0
		break
	fi
	sleep 0.1
done
