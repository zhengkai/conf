#! /usr/bin/env bash

LOCK_FILE="${HOME}/dev/hypr/$(basename "$0").lock"
exec 200>"$LOCK_FILE"
flock -n 200 || exit

set -x

hyprctl dispatch exec "[workspace name:wezterm silent; fullscreen] wezterm start --always-new-process -- ${HOME}/conf/script/tmux-tilda.sh"

sleep 3

hyprctl dispatch exec "[workspace name:log silent; fullscreen] wezterm start --always-new-process -- ~/conf/bin/tmu"
