#!/bin/sh
name="iconfans_db"
source_path="iconfans:/www/backup/"
target_path="${HOME}/backup/${name}"

run_file="/tmp/${name}_rsync"
check_file="${run_file}_check"
time_file="${run_file}_time"

echo `date +'%Y-%m-%d %H:%M:%S'` > $check_file

if [ -f $run_file ]
then
	echo "\n\t${name} backup 已经在运行\n"
	exit
fi

touch $run_file

find $target_path -mtime +456 -exec rm -f {} \;

echo `date +'%Y-%m-%d %H:%M:%S'` > $time_file

/usr/bin/rsync --temp-dir=/tmp --min-size=5000 --partial -vzrtopg -e ssh $source_path $target_path

sleep 5

find $target_path -mtime +3 -type f -writable -name '*\.sql\.gz' -exec chmod 000 {} \;
find $target_path -user $USER -type f -perm 000 -exec sudo chown root:root {} \;

rm -f $run_file
