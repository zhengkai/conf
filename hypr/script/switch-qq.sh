#! /usr/bin/env bash

WORKSPACE="qq"

current=$(hyprctl activeworkspace -j | jq -r '.name')
if [ "$current" == "$WORKSPACE" ]; then
	hyprctl dispatch workspace previous
	exit
fi
hyprctl dispatch workspace "name:${WORKSPACE}"

pgrep -x qq && exit 1

"$(dirname "$(readlink -f "$0")")/start-qq.sh" > /tmp/qq.txt
