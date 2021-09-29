#!/bin/bash

if [ ! -e /usr/bin/docker ]; then
	exit
fi

sudo docker pull golang &
sudo docker pull alpine &

wait
sudo docker image prune --force
