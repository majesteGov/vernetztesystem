 #!/bin/bash

 rm -rf ip*
 name=work-a
 mkdir -p outer/$name 

docker container stop $name 
docker container rm $name

docker image build -t work .

docker container create --name $name --network mynetwork50 --publish 82:80 --volume $PWD/outer/$name:/common/outer work
docker container start $name

sleep 1
docker container cp my.cnf work-a:/root/.my.cnf
docker container exec -ti $name useradd -m -s /bin/bash vnsuser
docker container exec -ti --user vnsuser $name ssh-keygen -N '' -f /home/vnsuser/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub | docker container exec -i --user vnsuser $name tee -a /home/vnsuser/.ssh/authorized_keys

ip=$(docker container exec -t $name hostname -i| tr -d '\r')
echo "$ip" > ip-$ip


ssh-keyscan -H $ip 
ssh-keyscan $ip >> ~/.ssh/known_hosts

ssh vnsuser@$ip "sed -i 's/\01;32m/01;31m/g' .bashrc"
