#!/bin/bash

CHECK="/var/run/reboot-required"
if [ ! -e "$CHECK" ]; then
	exit
fi

sudo killall /usr/local/bin/node
NODE="${HOME}/build/node/run.sh"
if [ -e "$NODE" ]; then
	"$NODE"
fi

SS="${HOME}/build/shadowsocks/run.sh"
if [ -e "$SS" ]; then
	"$SS" kill
fi
