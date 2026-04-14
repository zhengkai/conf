#!/usr/bin/env bash

if [ -z "$DISPLAY" ]; then
	exit
fi

gsettings set org.gnome.desktop.interface enable-animations false

cd "$(dirname "$(readlink -f "$0")")" || exit 1
readarray -t list < list-desktop

sudo apt-get update
sudo apt-get install -y "${list[@]}"
