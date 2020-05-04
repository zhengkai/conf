#!/bin/sh
bakname="/home/zhengkai/backup/soulogic/db_`date +%y%m%d_%H%M`.sql.gz"

dir=`dirname $bakname`

find $dir -mtime +10 -exec rm -f {} \;

/usr/bin/mysqldump --add-drop-database --add-drop-table --add-locks --hex-blob --quick --databases soulogic soulogic_pda | gzip --best > $bakname
