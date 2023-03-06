#!/bin/bash

name=apache-a

rm -f ip-*
mkdir -p outer/$name
docker image build -t apache .
docker container stop $name
docker container rm $name

docker container create --name $name --network mynetwork50 --publish 80:80 --volume $PWD/outer/$name/:/common/outer apache
docker container start $name
ip=$(docker container exec -t $name hostname -i| tr -d '\r' )
echo "$ip" > ip-$ip

#while ! ssh-keyscan $ip ; do echo -n .; sleep 0.1; done; echo

docker container cp my.cnf $name:/root/.my.cnf
docker container exec -ti $name useradd -m -s /bin/bash vnsuser
docker container exec -ti --user vnsuser $name ssh-keygen -N '' -f /home/vnsuser/.ssh/id_rsa

ssh-keyscan -R $ip
ssh-keyscan $ip >> ~/.ssh/known_hosts
cat ~/.ssh/id_rsa.pub | docker exec -i --user vnsuser $name tee -a /home/vnsuser/.ssh/authorized_keys
#scp runner.sh siuser@$ip:
#ssh siuser@$ip "nohup ./runner.sh &>/dev/null &"



