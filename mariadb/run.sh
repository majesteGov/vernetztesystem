#!/bin/bash

name=mariadb-a
rm -f ip-*
mkdir  -p outer/$name 

docker container stop $name 
docker container rm $name 

docker image build -t mariadb .

docker container create --name $name --network mynetwork --hostname mariadb-a --volume $PWD/outer/$name/:/outer --volume $PWD/../common/:/common/ mariadb
docker container start $name

ip=$(docker container exec -t $name hostname -i| tr -d '\r' )
echo $ip > ip-$ip

while ! ssh-keyscan $ip &>/dev/null;do echo -n .;sleep 0.1;done; echo

docker container exec -ti $name mariadb -e "create database db"
docker container exec -ti $name mariadb -e "create user user"
docker container exec -ti $name mariadb -e "grant all privileges on *.* to 'user'@'%' identified by 'password'"
docker container exec -ti $name mariadb -e "flush privileges"
docker container exec -ti $name mariadb db -e "create table userinfo (id integer auto_increment primary key,vorname text,name text)"
docker container exec -ti $name mariadb db -e "insert into userinfo (vorname,name) values ('majeste','silatsa')"

docker container exec -ti $name useradd -m -s /bin/bash user
docker container exec -ti --user user $name ssh-keygen -N '' -f /home/user/.ssh/id_rsa

ssh-keygen -R $ip
ssh-keyscan $ip >> ~/.ssh/known_hosts
cat ~/.ssh/id_rsa.pub | docker exec -i --user user $name tee -a /home/user/.ssh/authorized_keys
scp my.cnf user@$ip:/home/user/.my.cnf 
ssh user@$ip whoami
