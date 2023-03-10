#!/bin/bash
logfile=/outer/docker.log

trap onexit SIGTERM

function onexit {
  service ssh stop &>> $logfile
  kill $(cat /var/run/haproxy.pid) &>> $logfile
  sleep 1
  ps -ef >> $logfile
  exit
}

echo "start haproxy" >> $logfile
/usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg -D -p /var/run/haproxy.pid &>> $logfile
service ssh start

while true; do
  echo ping >> $logfile
  read -t60 </dev/fd/1
done
