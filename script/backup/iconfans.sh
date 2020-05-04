#!/bin/sh
name="iconfans_full"
source_path="iconfans:/www/iconfans/"
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

echo `date +'%Y-%m-%d %H:%M:%S'` > $time_file

/usr/bin/rsync --temp-dir=/tmp --partial -vzrtopg -e ssh $source_path $target_path

sleep 5

rm -f $run_file
