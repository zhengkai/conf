#!/bin/bash

echo 'installing...'

cd $(dirname `readlink -f $0`)

if [ ! -e /usr/share/X11/xkb/symbols/zhengkai ]; then
	echo
	echo 'add symbols'
	sudo cp ./zhengkai /usr/share/X11/xkb/symbols/
fi

match=`grep 'zhengkai:' /usr/share/X11/xkb/rules/evdev | head -n 1`

if [ -n "$match" ]; then
	echo
	echo 'rule added, skip'
else
	echo
	echo 'add rule'
	sudo sed -i "0,/  ctrl:nocaps/s//  zhengkai:base     = +zhengkai\(base\)\n  zhengkai:esc      = +zhengkai\(esc\)\n  zhengkai:hhkb_esc = +zhengkai\(hhkb_esc\)\n  ctrl:nocaps/" \
		/usr/share/X11/xkb/rules/evdev
fi

ESC='esc'
if [ "$HOSTNAME" == 'Tesla' ]; then
	ESC='hhkb_esc'
fi
XKBSET="['ctrl:nocaps','zhengkai:base','zhengkai:${ESC}']"

match=`grep 'zhengkai:' /usr/share/X11/xkb/rules/evdev | head -n 1`
if [ -n "$match" ]; then
	echo
	echo 'gsettings set' $XKBSET
	gsettings set org.gnome.desktop.input-sources xkb-options "$XKBSET"
else
	echo 'add rule failed'
fi

echo
echo 'end'
