#!/bin/bash -ex

cd /usr/local/src

if [ ! -d JetBrainsMono ]; then
	git clone --depth 1 https://github.com/JetBrains/JetBrainsMono.git
fi

cd JetBrainsMono/fonts/otf

git pull

sudo cp ./*.otf /usr/local/share/fonts
