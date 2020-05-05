#! /bin/bash

exec 200>"/tmp/rsync-freya-tesla.lock"
flock -x -n 200 || {
	>&2 echo
	>&2 echo "$0 is running"
	exit 1
}

source_path="freya:/log/"
target_path="/backup/freya/log"

rsync --temp-dir=/tmp --min-size=10 --partial -vzrtopg -e ssh "$source_path" "$target_path"

ssh freya "find /log -type f -ctime +10        -delete"
ssh freya "find /log -type d -ctime +1 -empty -delete"

source_path="freya:/backup/freya/"
target_path="/backup/freya/db"

rsync --temp-dir=/tmp --min-size=10 --partial -vzrtopg -e ssh "$source_path" "$target_path"

ssh freya "find /backup -type f -ctime +10        -delete"
ssh freya "find /backup -type d -ctime +1  -empty -delete"
