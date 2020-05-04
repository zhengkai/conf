#!/bin/bash

# 监视 DNS 查询

# sudo ./monitor-dns.sh | cronolog '/log/dns/%Y.%m/%d'

sudo tcpdump -A -l -K dst port 53 2>/dev/null \
	| stdbuf -o0 grep -o -E 'A\? .*? ' \
	| stdbuf -o0 cut -d ' ' -f 2

	# | ( read h; echo ${h:0:-1} )
