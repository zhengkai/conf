#!/bin/bash

if [ ! -e ~/.venvs/default/bin/python ]; then
	sudo apt install python3-venv
	mkdir -p ~/.venvs
	python3 -m venv ~/.venvs/default
	hash -r
fi

pip install --upgrade pip

pip freeze --local \
	| grep -v '^\-e' \
	| cut -d = -f 1  \
	| xargs -n1 pip install --upgrade

pip install --upgrade jinja2
pip install --upgrade httpie
pip install --upgrade qrcode
pip install --upgrade pynvim
pip install --upgrade yt-dlp
pip install --upgrade pyright
