#!/bin/bash
rm -f ip-*
name=latex-a
mkdir -p outer/$name && touch outer/$name
docker image build -t latex .
docker container stop $name
docker container rm $name

docker container create --name $name --network mynetwork --hostname $name --volume $PWD/../common/:/common/ --volume $PWD/outer/$name/:/outer latex

docker container start $name

ip=$(docker container exec -t $name hostname -i| tr -d '\r' )
echo "$ip" > ip-$ip

#while ! ssh-keyscan $ip &>/dev/null; do echo -n .; sleep 0.5; done; echo

docker container exec -ti $name useradd -m -s /bin/bash user
docker container exec -ti --user user $name ssh-keygen -N '' -f /home/user/.ssh/id_rsa
docker exec -i --user user --workdir /home/user $name tar -xf- < letter.tar
#docker exec -i --user user --workdir /ho 

me/user/letter/ latex-a ./run.sh
#docker exec -i --user user --workdir /home/user/letter/ latex-a rm data/first.pdf data/fonts.pdf

ssh-keygen -R $ip
ssh-keyscan $ip >> ~/.ssh/known_hosts
cat ~/.ssh/id_rsa.pub | docker exec -i --user user $name tee -a /home/user/.ssh/authorized_keys
#docker container update --restart unless-stopped $name
docker container exec -i $name tee -a /etc/security/limits.conf <<<"user-maxlogins 100"

