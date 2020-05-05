#!/bin/bash

CHECK="/var/run/reboot-required"
if [ ! -e "$CHECK" ]; then
	exit
fi

sudo killall /usr/local/bin/node
NODE="${HOME}/build/node/run.sh"
if [ -e /usr/local/bin/node ] && [ -e "$NODE" ]; then
	"$NODE"
fi

SS="${HOME}/build/shadowsocks/run.sh"
if [ -e /usr/local/bin/ss-local ] && [ -e "$SS" ]; then
	"$SS" kill
fi
