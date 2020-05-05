#!/bin/bash

TARGET_DIR="/backup/${HOSTNAME,,}"

if [[ ! -d "$TARGET_DIR" || ! -w "$TARGET_DIR" ]]; then
	>&2 echo "can not write dir $TARGET_DIR"
	exit 1
fi

exec 200>"/tmp/mysql-full-dump.lock"
flock -x -n 200 || {
	>&2 echo
	>&2 echo "$0 is running"
	exit 1
}

SKIP_DB=('information_schema' 'performance_schema' 'mysql' 'sys')

for DB_NAME in $(echo 'show databases' | mysql -N); do

	for SKIP in "${SKIP_DB[@]}"; do
		if [[ "$SKIP" == "$DB_NAME" ]]; then
			continue 2
		fi
	done

	echo

	FILENAME="$TARGET_DIR/$DB_NAME/$(date +%Y-%m)/${DB_NAME}-db-$(date +%Y%m%d-%H%M).sql.gz"
	printf '%-12s %s' "$DB_NAME" "$FILENAME"

	DIRNAME=$(dirname "$FILENAME")
	mkdir -p "$DIRNAME" 2>/dev/null || {
		>&2 echo
		>&2 echo "ERROR: create dir $DIRNAME fail"
		continue
	}

	/usr/bin/mysqldump \
		--default-character-set=utf8mb4 \
		--set-charset=TRUE \
		--add-drop-database \
		--add-drop-table \
		--add-locks \
		--hex-blob \
		--quick \
		--databases "$DB_NAME" | gzip --best > "$FILENAME"

	# 只有最近 30 天内有超过 20 个文件，才会删除超过 35 天的老文件
	# 防止备份脚本失效后新老数据都没有了
	DBROOT=$(dirname "$DIRNAME")
	FILE_NUM=$(find "$DBROOT" -mtime -30 | wc -l)
	if [ "$FILE_NUM" -gt 20 ]; then
		find "$DBROOT" -mtime +35 -type f -exec rm -f {} \;
		find "$DBROOT" -empty -delete
	fi

done
