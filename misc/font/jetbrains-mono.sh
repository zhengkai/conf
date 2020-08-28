#!/bin/bash -ex

cd /usr/local/src

if [ ! -d JetBrainsMono ]; then
	git clone --depth 1 git@github.com:JetBrains/JetBrainsMono.git
fi

cd JetBrainsMono/ttf

git pull

sudo cp ./*.ttf /usr/local/share/fonts

cd 'No ligatures'

sudo cp ./*.ttf /usr/local/share/fonts
