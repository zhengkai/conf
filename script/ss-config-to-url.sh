#! /bin/bash -ex

"$(dirname `readlink -f $0`)/ss-config-to-url.php" "$1" | qr
