#!/bin/bash

logfile=/outer/docker.log

trap onexit SIGTERM 
function onexit {
	service mariadb stop &>> $logfile
	service ssh stop &>$logfile
	sleep 1 
	ps -ef >>$logfile
	exit
}

echo "start mariadb2" >>$logfile
sed -i 's/^bind-address.*/bind-address = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i "s/^#max_connections.*/max_connections = 2005\nwait_timeout = 3600\ninteractive_timeout = 3600/g" /etc/mysql/mariadb.conf.d/50-server.cnf
service mariadb start
service ssh  start 
while true;do 
	echo ping >>$logfile
	read -t60 </dev/fd/1
done
