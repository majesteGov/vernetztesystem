 #!/bin/bash

 name=latex-a
 mkdir -p outer/$name 

docker container stop $name 
docker container rm $name

docker image build -t latex .

docker container create --name $name --network mynetwork50 --publish 80:80 --volume $PWD/outer/:/common/outer latex
docker container start $name

sleep 2

ip=$(docker container $name exec -t  hostname -i| tr -d '\r')
echo "$ip" > ip-$ip
