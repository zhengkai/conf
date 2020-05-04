#!/bin/sh
run_file="/tmp/emule_rsync"

echo `date +'%Y-%m-%d %H:%M:%S'` > /tmp/emule_rsync_check

if [ -f $run_file ] 
then 
	echo "\n\teMule rsync 已经在运行\n"
	exit
fi

touch $run_file

echo `date +'%Y-%m-%d %H:%M:%S'` > /tmp/emule_rsync_run

#/usr/bin/rsync --bwlimit=200 --temp-dir=/download/tmp --partial -vzrtopg -e "ssh -o TCPKeepAlive=yes -o ServerAliveInterval=30" aeon:/var/lib/mldonkey/incoming/files/ /download/emule/
#/usr/bin/rsync --temp-dir=/www/tmp --partial -vzrtopg -e "ssh -o TCPKeepAlive=yes -o ServerAliveInterval=30" aeon:/var/lib/mldonkey/incoming/files/ /www/emule/
#/usr/bin/rsync --temp-dir=/www/tmp --partial -vzrtopg -e "ssh -o TCPKeepAlive=yes -o ServerAliveInterval=30" aeon:/home/zhengkai/rtorrent/download/ /www/emule/

/usr/bin/rsync --temp-dir=/share/tmp --partial -vzrtopg -e ssh garona:~/rtorrent/move/ /share/garona/

#/usr/bin/rsync --include "apache-log**" --include "awstats**" --include "bin**" --include "chroot**" --include "etc**" --include "home**" --include "ifstat**" --include "lib**" --include "mnt**" --include "opt**" --include "root**" --include "rsync**" --include "sbin**" --include "svn**" --include "usr**" --include "var**" --include "www**" --exclude "*" --temp-dir=/www/tmp --partial -vzrtopg -e "ssh -o TCPKeepAlive=yes -o ServerAliveInterval=30 -l root" aeon:/ /www/aeon/

sleep 5

rm -f $run_file

