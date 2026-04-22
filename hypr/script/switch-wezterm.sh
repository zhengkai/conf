#! /usr/bin/env bash

WORKSPACE="wezterm"
CLASS="org.wezfurlong.wezterm"

current=$(hyprctl activeworkspace -j | jq -r '.name')
if [ "$current" == "$WORKSPACE" ]; then
	hyprctl dispatch workspace previous
	exit
fi

hyprctl dispatch workspace "name:${WORKSPACE}"
has=$(hyprctl clients -j | jq --arg ws "$WORKSPACE" --arg class "$CLASS" '[.[] | select(.workspace.name == $ws and .class == $class)] | length')
if [ "$has" -gt 0 ]; then
	# notify-send -t 1000 "target $TARGET $has, exit"
	exit
fi

"$(dirname "$(readlink -f "$0")")/start-wezterm.sh"
