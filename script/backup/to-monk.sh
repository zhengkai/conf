#! /bin/bash

HOST="${1:-eirena}"

exec 200>"/tmp/rsync-${HOST}-tesla.lock"
flock -x -n 200 || {
	>&2 echo
	>&2 echo "$0 is running"
	exit 1
}

source_path="${HOST}:/log/"
target_path="/backup/${HOST}/log"
rsync --temp-dir=/tmp --min-size=10 --remove-source-files --partial -vzrtopg -e ssh "$source_path" "$target_path"

source_path="${HOST}:/backup/${HOST}/"
target_path="/backup/${HOST}/db"
rsync --temp-dir=/tmp --min-size=10 --remove-source-files --partial -vzrtopg -e ssh "$source_path" "$target_path"
