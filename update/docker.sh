#!/bin/bash

if [ ! -e /usr/bin/docker ]; then
	exit
fi

sudo docker pull golang &
sudo docker pull alpine &
sudo docker pull scratch &

wait
sudo docker image prune --force
