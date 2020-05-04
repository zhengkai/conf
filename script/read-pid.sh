#!/bin/bash

PID="$1"

if [ -z "$PID" ]; then
	>&2 echo no pid or exec
	exit 1
fi

EXE_LINK="/proc/$PID/exe"

if [ ! -L "$EXE_LINK" ]; then
	>&2 echo no pid $PID
	exit 2
fi
if [ ! -r "$EXE_LINK" ]; then
	>&2 echo can not read pid $PID
	exit 3
fi

EXE_READLINK=`readlink -f "$EXE_LINK" || :`
if [ -z "$EXE_READLINK" ]; then
	>&2 echo unknown pid $PID
	exit 4
fi

echo $EXE_READLINK
