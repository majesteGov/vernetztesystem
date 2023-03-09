#!/bin/bash

docker container rm -f apache-a mariadb-a haproxy-a work-a lateX-a

docker network rm mynetwork50
docker network create mynetwork --subnet 172.28.0.0/16
