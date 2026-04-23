#! /usr/bin/env bash

grim -g "$(hyprctl monitors -j | jq -r '.[] | select(.focused) | "\(.x),\(.y) \(.width/2)x\(.height/2)"')" \
	~/Pictures/fullscreen-"$(date "+%Y%m%d-%H%M%S")".png
