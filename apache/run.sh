#!/bin/bash

name=apache-a

rm -f ip-*
mkdir -p outer/$name
docker image build -t apache .
docker container stop $name
docker container rm $name

docker container create --name $name --network mynetwork --publish 82:80 --hostname $name --volume $PWD/../common/:/common/ --volume $PWD/outer/$name/:/outer apache
docker container start $name
ip=$(docker container exec -t $name hostname -i| tr -d '\r' )
echo "$ip" > ip-$ip

while ! ssh-keyscan $ip &>/dev/null; do echo -n .; sleep 0.2; done; echo

docker container cp my.cnf $name:/root/.my.cnf
docker container exec -ti $name useradd -m -s /bin/bash user
docker container exec -ti --user user $name ssh-keygen -N '' -f /home/user/.ssh/id_rsa

ssh-keygen -R $ip
ssh-keyscan $ip >> ~/.ssh/known_hosts
cat ~/.ssh/id_rsa.pub | docker exec -i --user user $name tee -a /home/user/.ssh/authorized_keys
#scp runner.sh siuser@$ip:
#ssh siuser@$ip "nohup ./runner.sh &>/dev/null &"



