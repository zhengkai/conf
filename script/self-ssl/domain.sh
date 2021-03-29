#!/bin/bash

# DOMAIN="edge-chat.messenger.com"
DOMAIN="${1:-edge-chat.facebook.com}"

echo "domain: $DOMAIN"

BASE="output/${DOMAIN}"

cd "$(dirname "$(readlink -f "$0")")" || exit 1

PASSPHRASE=""

SUBJECT="/CN=${DOMAIN}/O=Soulogic/C=US"

openssl genrsa -out "${BASE}.key" 2048
openssl req -new -subj "$SUBJECT" -key "${BASE}.key" -out "${BASE}.csr" -passin "pass:$PASSPHRASE"

cp ./tpl-v3.txt v3.ext
sed -i "s#DOMAIN#${DOMAIN}#g" v3.ext

openssl x509 -req -in "${BASE}.csr" \
	-CA ca/root-ca.pem -CAkey ca/root-ca.key -CAcreateserial \
	-extfile v3.ext -sha256 -days 1000 \
	-out "${BASE}.crt"

echo sudo cp "${BASE}.crt" /etc/nginx/ssl.d
echo sudo cp "${BASE}.key" /etc/nginx/ssl.d
