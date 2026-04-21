#! /usr/bin/env bash

hyprctl dispatch workspace 20001

VM_NAME="win11"

if ! virsh list --state-running --name | grep -q "^${VM_NAME}$"; then
	virsh start "${VM_NAME}" &>dev/null || :
fi
