#!/bin/bash

cd "$(dirname "$(readlink -f "$0")")" || exit 1

npm i \
	@ibm/plex-math \
	@ibm/plex-mono \
	@ibm/plex-sans \
	@ibm/plex-sans-arabic \
	@ibm/plex-sans-condensed \
	@ibm/plex-sans-devanagari \
	@ibm/plex-sans-hebrew \
	@ibm/plex-sans-jp \
	@ibm/plex-sans-kr \
	@ibm/plex-sans-tc \
	@ibm/plex-sans-sc \
	@ibm/plex-sans-thai \
	@ibm/plex-sans-thai-looped \
	@ibm/plex-serif
