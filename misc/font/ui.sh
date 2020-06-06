#!/bin/bash -ex

gsettings get org.gnome.desktop.interface document-font-name
gsettings get org.gnome.desktop.interface font-name
gsettings get org.gnome.desktop.interface monospace-font-name

# gsettings reset org.gnome.desktop.interface document-font-name
# gsettings reset org.gnome.desktop.interface font-name
# gsettings reset org.gnome.desktop.interface monospace-font-name

FONT='Microsoft YaHei'
FONT_MONO='Note Mono'

gsettings set org.gnome.desktop.interface document-font-name "$FONT 11"
gsettings set org.gnome.desktop.interface font-name "$FONT 11"
gsettings set org.gnome.desktop.interface monospace-font-name "$FONT_MONO 11"
