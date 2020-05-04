#!/bin/bash
pip freeze --local \
	| \grep -v '^\-e' \
	| cut -d = -f 1  \
	| HOME=/root xargs -n1 sudo pip install -U
