#!/bin/bash -ex

cd /usr/local/src

if [ ! -d IBMPlex ]; then
	git clone --depth 1 git@github.com:IBM/plex.git IBMPlex
fi

cd IBMPlex/IBM-Plex-Mono/fonts/complete/ttf

git pull

sudo cp ./*.ttf /usr/local/share/fonts
