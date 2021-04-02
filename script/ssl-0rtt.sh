#!/bin/bash

HOST="${1:-soulogic.com}"

REQUEST="/tmp/request-0rtt.txt"
SESSION="/tmp/session-0rtt.txt"

echo -e "GET / HTTP/1.1\r\nHost: $HOST\r\nConnection: close\r\n\r\n" > "$REQUEST"
openssl s_client -connect "${HOST}:443" -tls1_3 -sess_out "$SESSION" -ign_eof < "$REQUEST"
echo | openssl s_client -connect "${HOST}:443" -tls1_3 -sess_in "$SESSION" -early_data "$REQUEST"
