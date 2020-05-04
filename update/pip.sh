#!/bin/bash

sudo -H pip3 install --upgrade httpie
sudo -H pip3 install --upgrade qrcode
sudo -H pip3 install --upgrade tldr
sudo -H pip3 install --upgrade thefuck
sudo -H pip3 install --upgrade youtube-dl

pip3 freeze --local \
	| \grep -v '^\-e' \
	| cut -d = -f 1  \
	| xargs -n1 sudo -H pip3 install -U
