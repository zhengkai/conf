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
fi

echo "h $HOST"
echo "h $HOSTNAME"
