#! /usr/bin/env bash

VM_NAME="win11"

hyprctl dispatch workspace "name:${VM_NAME}"

set -x
if ! virsh list --state-running --name | grep -q "^${VM_NAME}$"; then
	virsh start "${VM_NAME}" &>/dev/null || :
fi
