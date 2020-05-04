#!/bin/bash

name='bt'
tmux='/usr/bin/tmux'

has_session=true
$tmux has-session -t $name 2>/dev/null || has_sesion=false

if [ "$has_sesion" = false ]; then

	$tmux -2 new-session -d -s $name rtorrent

	$tmux set-option -t "$name" -q status "off"

fi

$tmux -2 attach -t $name
