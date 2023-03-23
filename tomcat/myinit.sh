#!/bin/bash
logfile=/outer/docker.log

trap onexit SIGTERM

function onexit {
  sudo -u tocmat /opt/tomcat/bin/shutdown.sh 10
  service ssh stop &>> $logfile
  sleep 1
  ps -ef >> $logfile
  exit
}

echo "start Tomcat" >> $logfile
sudo -u tomcat /opt/tomcat/startup.sh
service ssh start

while true; do
  echo ping >> $logfile
  read -t60 </dev/fd/1
done
