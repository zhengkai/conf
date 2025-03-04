#!/bin/bash

acl sudo /etc/hosts
acl sudo /etc/fstab
acl sudo /etc/passwd
acl sudo /etc/rc.local
acl sudo /etc/resolv.conf
acl sudo /etc/apt/sources.list.d
acl sudo /etc/tmpfiles.d

if [ -d /etc/nginx ]; then
	acl sudo /etc/nginx/nginx.conf
	acl sudo /etc/nginx/vhost.d
	acl sudo /etc/nginx/ssl.d
fi

acl sudo /usr/local/src
