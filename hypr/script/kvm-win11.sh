#! /usr/bin/env bash

hyprctl dispatch workspace 20001

sleep 1

virt-viewer --full-screen --connect qemu:///system --attach win11
