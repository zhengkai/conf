#!/bin/bash -ex

if [ "$(which acl)" != "${HOME}/conf/bin/acl" ]; then
	>&2 echo not yet
	exit 1
fi

acl sudo /usr/local/src

acl sudo /etc/nginx/conf.d || :
acl sudo /etc/nginx/vhost.d || :
acl sudo /etc/nginx/nginx.conf || :

acl sudo /etc/rc.local
acl sudo /etc/hosts
acl sudo /etc/hostname
acl sudo /etc/fstab

acl sudo /etc/ssh/ssh_config
acl sudo /etc/ssh/sshd_config
acl sudo /etc/sysctl.d

sudo mkdir -p /go/tmp
acl sudo /go

sudo mkdir -p /log/start
acl sudo /log

sudo mkdir -p /var/lib/GeoIP
acl sudo /var/lib/GeoIP

~/build/stderred/run.sh

~/build/go/run.sh
go install github.com/mattn/efm-langserver@latest

~/build/nvim/config.sh
~/build/nvim/run.sh
