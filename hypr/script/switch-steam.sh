#! /usr/bin/env bash

WORKSPACE="steam"

current=$(hyprctl activeworkspace -j | jq -r '.name')
if [ "$current" == "$WORKSPACE" ]; then
	hyprctl dispatch workspace previous
	exit
fi
hyprctl dispatch workspace "name:${WORKSPACE}"

pgrep -x steam && exit 1

unset http_proxy
unset https_proxy

unset HTTP_PROXY
unset HTTPS_PROXY

unset LD_PRELOAD

steam -forcedesktopscaling=2 %U > /tmp/steam.txt
