#!/bin/bash

# DOMAIN="edge-chat.messenger.com"
DOMAIN="edge-chat.facebook.com"

BASE="output/${DOMAIN}"

cd "$(dirname "$(readlink -f "$0")")" || exit 1

PASSPHRASE=""

SUBJECT="/CN=${DOMAIN}/O=Soulogic/C=US"

openssl genrsa -out "${BASE}.key" 2048
openssl req -new -subj "$SUBJECT" -key "${BASE}.key" -out "${BASE}.csr" -passin "pass:$PASSPHRASE"

openssl x509 -req -in "${BASE}.csr" \
	-CA ca/root-ca.pem -CAkey ca/root-ca.key -CAcreateserial \
	-extfile v3.ext -sha256 -days 1000 \
	-out "${BASE}.crt"

sudo cp output/edge-chat.messenger.com.crt /etc/nginx/ssl.d
sudo cp output/edge-chat.messenger.com.key /etc/nginx/ssl.d
