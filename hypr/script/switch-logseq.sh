#! /usr/bin/env bash

WORKSPACE="logseq"

current=$(hyprctl activeworkspace -j | jq -r '.name')
if [ "$current" == "$WORKSPACE" ]; then
	hyprctl dispatch workspace previous
	exit
fi
hyprctl dispatch workspace "name:${WORKSPACE}"

pgrep -x Logseq-linux-x64 && exit 1

unset LD_PRELOAD

appimage-run /opt/logseq/Logseq-linux-x64-0.10.15.AppImage /home/zhengkai/logseq
