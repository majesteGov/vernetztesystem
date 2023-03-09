#!/bin/bash
logfile=/outer/docker.log

trap onexit SIGTERM

function onexit {
  service apache2 stop &>> $logfile
  service ssh stop &>> $logfile
  sleep 1
  ps -ef >> $logfile
  exit
}

echo "start apache2" >> $logfile
sed -i -E 's/^i(#ServerRoot.*)/\1\nServerName meiner/g' /etc/apache2/apache2.conf
service apache2 start
service ssh start

while true; do
  echo ping >> $logfile
  read -t60 </dev/fd/1
done
