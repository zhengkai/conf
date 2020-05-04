#!/bin/bash

sudo /usr/bin/openssl ocsp -noverify \
	-issuer /etc/nginx/ssl/sub.class1.server.ca.pem \
	-cert /etc/nginx/ssl/soulogic.com.crt \
	-header "HOST" "ocsp.startssl.com" \
	-url http://ocsp.startssl.com/sub/class1/server/ca \
	-respout /etc/nginx/ssl/soulogic.com.ocsp

sudo chmod 400 /etc/nginx/ssl/soulogic.com.ocsp
