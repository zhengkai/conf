#!/usr/bin/env bash

if [ "$(which pip)" != "${HOME}/dev/venvs/default/bin/pip" ]; then
	exit 1
fi

pip install --upgrade yt-dlp
pip install --upgrade secretstorage
pip install --upgrade keyring
