#! /usr/bin/env bash

WORKSPACE="chrome-office"
PROFILE="Profile 5"

hyprctl dispatch workspace "name:${WORKSPACE}"
has=$(hyprctl clients -j | jq --arg ws "$WORKSPACE" '[.[] | select(.workspace.name == $ws)] | length')
if [ "$has" -gt 0 ]; then
	exit
fi
google-chrome --profile-directory="$PROFILE"
