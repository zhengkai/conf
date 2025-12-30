#!/bin/bash

set -euo pipefail

SRC_DIR="/share"
DST="doll:/bt/watch"

find "$SRC_DIR" -type f -name '*[[]BTSCHOOL[]]*.torrent' -print0 |
while IFS= read -r -d '' file; do
    echo "Syncing: $file"
    rsync -av --remove-source-files "$file" "${DST}/"
done
