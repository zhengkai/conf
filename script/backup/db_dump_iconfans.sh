#!/bin/sh
bakname="/backup/iconfans_db_`date +%y%m%d_%H%M`.sql.gz"

dir=`dirname $bakname`

find $dir -mtime +35 -exec rm -f {} \;

/usr/bin/mysqldump \
 --default-character-set=utf8mb4 \
 --set-charset=TRUE \
 --add-drop-database \
 --add-drop-table \
 --add-locks \
 --hex-blob \
 --quick \
 --databases iconfans_bbs | gzip --best > $bakname
