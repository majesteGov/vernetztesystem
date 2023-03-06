#!/bin/bash

logfile=/outer/docker.log

trap onexit SIGTERM

function onexit {
	ps -ef >> $logfile
	service ssh stop
	apachectl stop
	ps -ef >> $logfile
	exit 
}

echo "ssh start" >> $logfile 
service ssh start 
apachectl start
date >>$logfile

while true;do 
	echo ping >> $logfile
	read -t60 < /dev/fd/1
done

