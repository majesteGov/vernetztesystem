#!/bin/bash

logfile=/outer/docker.log

trap onexit SIGTERM 
function onexit {
	service mariadb stop &>> $logfile
	sleep 1 
	ps -ef >>$logfile
	exit
}

echo "start mariadb2" >>$logfile
sed -i 's/^bind-address.*/bind-address = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
service mariadb start

while true;do 
	echo ping >>$logfile
	read -t60 </dev/fd/1
done
