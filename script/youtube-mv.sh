#!/bin/bash

DIR="/monk/youtube"
if [ ! -d "$DIR" ]; then
	>&2 echo 'no dir '$DIR
	exit 1
fi

FILE="$1"
if [ ! -f "$FILE" ]; then
	>&2 echo 'no file '$FILE
	exit 1
fi

mv "$FILE" "$DIR"

FILENAME=`basename "$FILE"`
chmod 666 "${DIR}/$FILENAME"
