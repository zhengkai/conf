#!/bin/bash

IF=$(ifconfig -s | \grep -E '^(eth|enp|ens|wlp)' | awk '{print $1}' | tr '\n' ',' | sed 's/,$//')

if [ -n "$IF" ]; then
	ifstat -t -i "$IF" "$@"
	exit
fi

ifstat -t "$@"
