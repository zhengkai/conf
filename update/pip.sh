#!/bin/bash

pip freeze --local \
	| grep -v '^\-e' \
	| cut -d = -f 1  \
	| xargs -n1 pip3 install --upgrade --no-warn-script-location

pip install --upgrade --no-warn-script-location httpie
pip install --upgrade --no-warn-script-location qrcode
pip install --upgrade --no-warn-script-location thefuck
pip install --upgrade --no-warn-script-location pynvim
pip install --upgrade --no-warn-script-location yt-dlp
