#!/bin/bash

docker container rm -f apache-a mariadb-a haproxy-a work-a latex-a tomcat-a 

docker network rm mynetwork
docker network create mynetwork --subnet 172.28.0.0/16
