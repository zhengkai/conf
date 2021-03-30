#!/bin/bash

host="ngx.hk"
echo -e "GET / HTTP/1.1\r\nHost: $host\r\nConnection: close\r\n\r\n" > request.txt
openssl s_client -connect $host:443 -tls1_3 -sess_out session.pem -ign_eof < request.txt
echo | openssl s_client -connect $host:443 -tls1_3 -sess_in session.pem -early_data request.txt
