#!/bin/bash

export GOROOT=/usr/local/go
export GOARCH=amd64
export GOOS=linux
export GOPATH=/go

BIN='/usr/local/go/bin/godoc'

PID_FILE='pid.txt'

DIR=`readlink -f "$0"` && DIR=`dirname "$DIR"` && cd "$DIR" || exit 1

PID=`cat "$PID_FILE" 2>/dev/null || :`

if [ -n "$PID" ]; then
	../safe-kill.sh "$PID" "$BIN"
fi

"$BIN" -http ':6060' >/dev/null 2>&1 &

PID="$!"

echo "$PID" > "$PID_FILE"
echo "$PID"
