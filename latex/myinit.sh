#!/bin/bash
logfile=/outer/docker.log

trap onexit SIGTERM

function onexit {
  service apache2 stop &>> $logfile
  service ssh stop &>> $logfile
  sleep 0.1
  ps -ef &>> $logfile
  exit
}

echo "start Latex" >> $logfile

sed -i -E 's/^(#ServerRoot.*)/\1\nServerName latexapache/g' /etc/apache2/apache2.conf

service ssh start
service apache2 start

while true; do
  echo ping >> $logfile
  read -t60 </dev/fd/1
done
