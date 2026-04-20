#! /usr/bin/env bash

cd "$(dirname "$(readlink -f "$0")")" || exit 1

rsync --partial -vzrtopg --exclude-from=rsync-exclude.txt \
 /www /archive /home tanya:/mnt/black/anna
