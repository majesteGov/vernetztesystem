#!/bin/bash

echo "apache is starting"
(cd apache && ./run.sh) 
echo "haproxy is starting"
(cd haproxy && ./run.sh)
echo "mariadb is starting"
(cd mariadb && ./run.sh) 
echo "latex is starting"
(cd lateX && ./run.sh) 
echo "work is starting"
(cd work && ./run.sh)
