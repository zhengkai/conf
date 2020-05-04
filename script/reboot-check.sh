#!/bin/sh

CHECK_FILE='/usr/lib/update-notifier/update-motd-reboot-required'

if [ ! -x "$CHECK_FILE" ]; then
	exit
fi

CHECK=`$CHECK_FILE | grep -m 1 'System restart required'`

if [ -z "$CHECK" ]; then
	exit
fi

echo 'reboot'
sudo reboot
