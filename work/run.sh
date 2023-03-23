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
while ! ssh-keyscan $ip&>/dev/null;do echo -n .;sleep 0.1; done; echo 

docker container exec -ti $name useradd -m -s /bin/bash user
docker container exec -ti --user user $name ssh-keygen -N '' -f /home/user/.ssh/id_rsa

ssh-keygen -R $ip 
ssh-keyscan $ip >> ~/.ssh/known_hosts
cat ~/.ssh/id_rsa.pub | docker container exec -i --user user $name tee -a /home/user/.ssh/authorized_keys

#docker container exec -i $name tar -xf- < work-etc-ssh.tar
cat ~/.ssh/id_rsa.pub | ssh user@$ip "tee -a ~/.ssh/authorized_keys" >/dev/null

ssh user@$ip "sed -i 's/\01;32m/01;35m/g' .bashrc"

scp my.cnf user@$ip: .my.cnf
scp testordner/test*.sh user@$ip:
scp -r fifos user@$ip:
