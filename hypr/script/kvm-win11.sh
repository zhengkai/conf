#! /usr/bin/env bash

hyprctl dispatch exec "[workspace name:win11 silent] virt-viewer --full-screen --connect qemu:///system --attach win11"
