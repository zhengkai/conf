#!/bin/sh

TARGET_DIR='/www/manual/php'

LOCK_FILE='/tmp/php.manual.lock'

if [ ! -d "$TARGET_DIR" ]; then
	echo "dir \"$TARGET_DIR\" don't exists"
	exit
fi
if [ ! -w "$TARGET_DIR" ]; then
	echo "dir \"$TARGET_DIR\" is not writable"
	exit
fi

flock -n $LOCK_FILE /usr/bin/rsync -avzC --timeout=600 --delete --delete-after \
 --exclude='.git' \
 --include='manual/en/' --include='manual/en/**' --exclude='manual/**' \
 --exclude='distributions' \
 rsync.php.net::phpweb $TARGET_DIR
