 #!/bin/bash

 rm -rf ip*
 name=work-a
 mkdir -p outer/$name 

docker container stop $name 
docker container rm $name

docker image build -t work .

docker container create --name $name --network mynetwork --publish 81:80 --hostname $name --volume $PWD/outer/$name/:/outer --volume $PWD/../common/:/common/  work
docker container start $name

sleep 1
ip=$(docker container exec -t $name hostname -i| tr -d '\r')
echo "$ip" > ip-$name-$ip
while ! ssh-keyscan $ip>&/dev/null;do echo -n .;sleep 0.5; done; echo 

docker container cp my.cnf work-a:/root/.my.cnf
docker container exec -ti $name useradd -m -s /bin/bash user
docker container exec -ti --user user $name ssh-keygen -N '' -f /home/user/.ssh/id_rsa

ssh-keygen -R $ip 
ssh-keyscan $ip >> ~/.ssh/known_hosts
cat ~/.ssh/id_rsa.pub | docker container exec -i --user user $name tee -a /home/user/.ssh/authorized_keys

#ssh user@$ip "sed -i 's/\01;32m/01;31m/g' .bashrc"
