#!/bin/bash

pip3 install --upgrade --no-warn-script-location httpie
pip3 install --upgrade --no-warn-script-location qrcode
pip3 install --upgrade --no-warn-script-location tldr
pip3 install --upgrade --no-warn-script-location thefuck

pip3 freeze --local \
	| grep -v '^\-e' \
	| cut -d = -f 1  \
	| xargs -n1 pip3 install --upgrade --no-warn-script-location
