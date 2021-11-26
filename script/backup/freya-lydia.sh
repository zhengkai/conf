#! /bin/bash

HOST="${1:-freya}"

exec 200>"/tmp/rsync-${HOST}-tesla.lock"
flock -x -n 200 || {
	>&2 echo
	>&2 echo "$0 is running"
	exit 1
}

source_path="${HOST}:/log/"
target_path="/backup/${HOST}/log"

rsync --temp-dir=/tmp --min-size=10 --partial -vzrtopg -e ssh "$source_path" "$target_path"

ssh "$HOST" "find /log -type f -ctime +10        -delete"
ssh "$HOST" "find /log -type d -ctime +1  -empty -delete"

source_path="${HOST}:/backup/${HOST}/"
target_path="/backup/${HOST}/db"

rsync --temp-dir=/tmp --min-size=10 --partial -vzrtopg -e ssh "$source_path" "$target_path"

ssh "$HOST" "find /backup -type f -ctime +10        -delete"
ssh "$HOST" "find /backup -type d -ctime +1  -empty -delete"
