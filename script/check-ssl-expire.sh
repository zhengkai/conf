#!/bin/bash

DOMAIN="${1:-soulogic.com}"
PORT="${2:-443}"
HOST="${3:-$DOMAIN}"

TIME=`echo | timeout 10 openssl s_client -showcerts -servername "$DOMAIN" -connect "${DOMAIN}:${PORT}" 2>/dev/null | openssl x509 -noout -dates | grep notAfter | cut -d '=' -f 2`

if [ -z "$TIME" ]; then
	exit 1
fi

date '+%s' -d "$TIME"
echo
echo domain: $DOMAIN
echo "  port: $PORT"
echo expire: `TZ='Asia/Shanghai' date '+%Y-%m-%d %H:%M:%S' -d "$TIME"`
