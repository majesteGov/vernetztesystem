#!/bin/bash

docker container rm -f apache-a mariadb-a haproxy-a work-a lateX-a

docker network rm mynetworrk50
docker network create mynetwork50 --subnet 172.27.0.0/16
