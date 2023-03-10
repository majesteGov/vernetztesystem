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

echo "start apache2" >> $logfile
sed -i -E 's/^(#ServerRoot.*)/\1\nServerName latexapache/g' /etc/apache2/apache2.conf
sed -i '/^#MaxStarups.*/MaxStartups 100:100:100/g' /etc/ssh/sshd_config
sed -i '/^#MaxSessions.*/MaxSessions 100/g' /etc/ssh/sshd_config
service apache2 start

service ssh start

while true; do
  echo ping >> $logfile
  read -t60 </dev/fd/1
done
