 #!/bin/bash

 name=haproxy-a
 mkdir -p outer/$name 

docker container stop $name
docker container rm $name

docker image build -t haproxy .

docker container create --name $name --network mynetwork50 --publish 80:80 --volume $PWD/outer/:/common/outer haproxy
docker container start $name

sleep 2

ip=$(docker container $name exec -t  hostname -i| tr -d '\r')
echo "$ip" > ip-$ip
