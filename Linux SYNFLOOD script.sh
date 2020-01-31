#!/bin/bash
syncookies=$(cat '/proc/sys/net/ipv4/tcp_syncookies')
if [ $syncookies -eq 1 ]; then
	echo 'SynFlood protection is enabled'
	exit 1
fi	
while [ $syncookies -eq 1 ]
	do
		lineCount=$(netstat -nt | grep SYN_RECV | wc -l)
		if [$lineCount -gt 10]; then
			logger SYN_FLOOD
		fi
		sleep 1m
	done
