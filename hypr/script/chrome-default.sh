#! /usr/bin/env bash

WORKSPACE="chrome-default"
PROFILE="Profile 1"

current=$(hyprctl activeworkspace -j | jq -r '.name')
if [ "$current" == "$WORKSPACE" ]; then
	hyprctl dispatch workspace previous
	exit
fi

hyprctl dispatch workspace "name:${WORKSPACE}"
has=$(hyprctl clients -j | jq --arg ws "$WORKSPACE" '[.[] | select(.workspace.name == $ws)] | length')
if [ "$has" -gt 0 ]; then
	exit
fi
google-chrome --profile-directory="$PROFILE"
