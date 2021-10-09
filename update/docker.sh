#!/bin/bash

if [ ! -e /usr/bin/docker ]; then
	exit
fi

update() {
	CHECK=$(sudo docker images | grep -E "^${1} " | head -n 1)
	echo "check $CHECK"
	if [ -n "$CHECK" ]; then
		sudo docker pull "$1" &
	fi
}

update golang
update alpine

wait
sudo docker image prune --all --force
