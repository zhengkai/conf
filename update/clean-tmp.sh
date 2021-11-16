#!/bin/bash

if [ -w /go/tmp ]; then
	find /go/tmp -mtime +10 -delete
fi
if [ -w ~/.tmp/vim-undo ]; then
	find ~/.tmp/vim-undo -mtime +10 -delete
fi
if [ -w ~/.tmp/vim-swap ]; then
	find ~/.tmp/vim-swap -mtime +10 -delete
fi

echo "h $HOST"
echo "h $HOSTNAME"
