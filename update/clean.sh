#!/bin/bash

if [ -w /go/tmp ]; then
	find /go/tmp -type f -mtime +10 -delete
fi
if [ -w ~/.tmp/vim-undo ]; then
	find ~/.tmp/vim-undo -type f -mtime +10 -delete
fi
if [ -w ~/.tmp/vim-swap ]; then
	find ~/.tmp/vim-swap -type f -mtime +10 -delete
fi
if [ -w ~/.config/nvim/backup ]; then
	find ~/.config/nvim/backup -type f -mtime +10 -delete
	find ~/.config/nvim/backup -type d -empty -delete
fi

sudo find /var/log/journal -name '*@*' -type f -ctime +10 -delete

/usr/bin/trash-empty 30

rm ~/.local/xgen || :
rm ~/.local/pgen || :

FILE=(
	'00-header'
	'10-help-text'
	'50-motd-news'
	'80-livepatch'
	'88-esm-announce'
)
for F in "${FILE[@]}"; do
	F="/etc/update-motd.d/${F}"
	if [ -e "$F" ]; then
		sudo rm "$F"
	fi
done
