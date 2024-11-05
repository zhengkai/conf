#!/bin/bash

PID=$(pgrep -f /opt/QQ/qq | sort | head -n 1)

if [ -n "$PID" ]; then
	kill "$PID"
fi
