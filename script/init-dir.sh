#! /bin/bash

if [ ! -e /go/tmp ]; then
	sudo mkdir -p /go/tmp
	acl sudo /go
fi

if [ ! -e /www ]; then
	sudo mkdir -p /www
	acl sudo /www
fi

if [ ! -e /backup ]; then
	sudo mkdir -p /backup
	acl sudo /backup
fi

if [ ! -e /log/default ]; then
	sudo mkdir -p /log/default
	acl www-data /log
fi
