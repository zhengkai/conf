#! /bin/bash

(

flock -x -n 200 || exit 1

source_path="freya:/log/"
target_path="/backup/freya/log"

rsync --temp-dir=/tmp --min-size=10 --partial -vzrtopg -e ssh "$source_path" "$target_path"

ssh freya "find /log -type f -ctime +10        -delete"
ssh freya "find /log -type d -ctime +1 -empty -delete"

source_path="freya:/backup/Freya/"
target_path="/backup/freya/db"

rsync --temp-dir=/tmp --min-size=10 --partial -vzrtopg -e ssh "$source_path" "$target_path"

ssh freya "find /backup -type f -ctime +10        -delete"
ssh freya "find /backup -type d -ctime +1  -empty -delete"

#source_path="flow:/backup/Flow/"
#target_path="/backup/flow/db"
#
#rsync --temp-dir=/tmp --min-size=10 --partial -vzrtopg -e ssh "$source_path" "$target_path"

) 200>/tmp/rsync-freya-tesla.lock
