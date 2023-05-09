#!/bin/bash

IF=$(ifconfig -s | \grep -E '^(eth|enp|ens)' | awk '{print $1}' | tr '\n' ',' | sed 's/,$//')

if [ -n "$IF" ]; then
	ifstat -i "$IF" "$@"
	exit
fi

ifstat "$@"
