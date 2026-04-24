#! /usr/bin/env bash

VM_NAME="win11"

hyprctl dispatch workspace "name:${VM_NAME}"

LOCK_FILE="${HOME}/dev/hypr/$(basename "$0")-${VM_NAME}.lock"
exec 200>"$LOCK_FILE"
flock -n 200 || exit

if ! virsh list --state-running --name | grep -q "^${VM_NAME}$"; then
	sudo virsh start "${VM_NAME}" &
fi

if [ "$(hyprctl activeworkspace -j | jq '.windows')" -eq 0 ]; then
	looking-glass-client -f /dev/shm/looking-glass
fi

sleep 3

# if ! virsh list --state-running --name | grep -q "^${VM_NAME}$"; then
# 	sudo virsh start "${VM_NAME}" &>/dev/null || :
# fi
