#!/bin/bash

if [ -z "$MAILGUN_KEY" ]; then
	>&2 echo "Error: MAILGUN_KEY is not set"
	exit 1
fi

if [ -z "$MAILGUN_FROM" ]; then
	>&2 echo "Error: MAILGUN_FROM is not set"
	exit 1
fi

if [ -z "$MAILGUN_DOMAIN" ]; then
	>&2 echo "Error: MAILGUN_DOMAIN is not set"
	exit 1
fi

if [ -z "$1" ]; then
	>&2 echo "Error: No recipient specified"
	exit 1
fi

if [ -z "$2" ]; then
	>&2 echo "Error: No subject specified"
	exit 1
fi

if [ -z "$3" ]; then
	>&2 echo "Error: No message specified"
	exit 1
fi

curl -s --user "api:${MAILGUN_KEY}" \
	"https://api.mailgun.net/v3/${MAILGUN_DOMAIN}/messages" \
	-F from="$MAILGUN_FROM" \
	-F to="$1" \
	-F subject="$2" \
	-F text="$3"
