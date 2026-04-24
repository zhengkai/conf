#! /usr/bin/env bash

hyprctl dispatch exec "[workspace name:wezterm silent; fullscreen] wezterm start --always-new-process -- ~/conf/script/tmux-tilda.sh"

sleep 3

hyprctl dispatch exec "[workspace name:log; fullscreen] wezterm start --always-new-process -- ~/conf/bin/tmu"
