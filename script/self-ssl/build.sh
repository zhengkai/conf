#!/bin/bash -e

cd "$(dirname "$(readlink -f "$0")")" || exit 1

if [ ! -e ca/root-ca.key ]; then
	mkdir -p ca
	openssl genrsa -out ca/root-ca.key 2048
fi

SUBJECT='/CN=Self CA/O=Soulogic/C=US'

openssl req -new -x509 -nodes -sha256 -days 3000 -subj "$SUBJECT" -key ca/root-ca.key -out ca/root-ca.pem

sudo cp ca/root-ca.pem /usr/local/share/ca-certificates/root-ca.crt

openssl x509 -in ca/root-ca.pem -noout -purpose
echo
openssl x509 -in ca/root-ca.pem -noout -issuer
echo
openssl x509 -in ca/root-ca.pem -noout -dates
echo
openssl x509 -in ca/root-ca.pem -noout -text | grep 'Signature Algorithm:' | head -n 1 | awk '{$1=$1;print}'

sudo update-ca-certificates
