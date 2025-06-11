#!/bin/bash -ex

VER="3.4.0"

FILE_BASE="/usr/local/src/nerd-fonts-symbols-only-v${VER}"
FILE="${FILE_BASE}.tar.xz"

if [ ! -e "$FILE" ]; then
	wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v${VER}/NerdFontsSymbolsOnly.tar.xz" \
		-O "$FILE"
fi

mkdir -p "$FILE_BASE"
tar -xf "$FILE" -C "$FILE_BASE"

CONF_BASE="10-nerd-font-symbols.conf"
CONF_FILE="/usr/share/fontconfig/conf.avail/${CONF_BASE}"
CONF_FINAL="/etc/fonts/conf.d/${CONF_BASE}"
sudo cp "${FILE_BASE}/10-nerd-font-symbols.conf" "$CONF_FILE"
sudo ln -sf "$CONF_FILE" "$CONF_FINAL"

sudo cp "${FILE_BASE}/"Symbols*.ttf /usr/local/share/fonts/

sudo fc-cache -fv

sudo fc-list | grep "Nerd Font"
