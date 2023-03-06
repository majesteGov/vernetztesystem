#!/bin/bash

name=mariadb-a
rm -f ip-*
mkdir  -p outer/$name 

docker container stop $name 
docker container rm $name 

docker image build -t mariadb .

docker container create --name $name --network mynetwork50 --volume $PWD/outer/$name/:/common/outer mariadb
docker container start $name
sleep 1

ip=$(docker container exec -t $name hostname -i| tr -d '\r')
echo "$ip" > ip-$ip

docker container exec -ti $name mariadb -e "create database db"
docker container exec -ti $name mariadb -e "create user dbuser"
docker container exec -ti $name mariadb -e "grant all privileges on *.* to user@'%' identified by 'password'"
docker container exec -ti $name mariadb -e "flush privileges"
docker container exec -ti $name mariadb db -e "create table demo(id integer auto_increment primary key,name text)"
docker container exec -ti $name mariadb db -e "insert into demo (name) values ('moin')"

#docker container exec -ti $name useradd -m -s bin/bash dbuser
#docker container exec -ti --user dbuser $name ssh-keygen -N '' -f home/dbuser/.ssh/id_ra
