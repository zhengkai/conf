#! /usr/bin/env bash

FILE="/tmp/Nordzy-hyprcursors.tar.gz"

wget https://github.com/guillaumeboehm/Nordzy-cursors/releases/download/v2.4.0/Nordzy-hyprcursors.tar.gz \
	-O "$FILE"

tar -xzf "$FILE" -C ~/.local/share/icons/
