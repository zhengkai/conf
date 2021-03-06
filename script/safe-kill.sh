#!/bin/bash

PID="$1"
EXEC="$2"

if [ -z "$PID" ] || [ -z "$EXEC" ]; then
	>&2 echo no pid or exec
	exit 1
fi

if [ "$PID" -lt 11 ]; then
	>&2 echo pid wrong
	exit 1
fi

EXE_LINK="/proc/$PID/exe"

if [ ! -L "$EXE_LINK" ]; then
	>&2 echo "no pid $PID"
	exit 2
fi
if [ ! -r "$EXE_LINK" ]; then
	>&2 echo "can not read pid $PID"
	exit 3
fi

EXE_READLINK=$(sudo readlink -f "$EXE_LINK" || :)
if [ -z "$EXE_READLINK" ]; then
	>&2 echo "unknown pid $PID"
	exit 4
fi
if [ "$EXE_READLINK" != "$EXEC" ]; then
	>&2 echo "pid $PID not file $EXEC (${EXE_READLINK})"
	exit 5
fi

echo "kill pid $PID $EXEC"
sudo kill "$PID"
while [ -e "/proc/${PID}/exe" ];
do
	sleep 1;
done;
