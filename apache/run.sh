#!/bin/bash

name=apache-a

rm -f ip-*
mkdir -p outer/$name
docker container stop $name
docker container rm $name
docker image build -t apache .
#--publish 82:80 -e ALLOWED_IP=172.28.0.4 
docker container create --name $name --network mynetwork --hostname $name --volume $PWD/../common/:/common/ --volume $PWD/outer/$name/:/outer apache
docker container start $name
ip=$(docker container exec -t $name hostname -i| tr -d '\r' )
echo "$ip" > ip-$ip

while ! ssh-keyscan $ip &>/dev/null; do echo -n .; sleep 0.1; done; echo

docker container cp my.cnf $name:/root/.my.cnf
docker container exec -ti $name useradd -m -s /bin/bash user
docker container exec -ti $name usermod -aG www-data user
docker container exec -ti $name chown -R www-data: /var/www/
docker container exec -ti $name chown -R user:www-data /var/www/html

docker container exec -ti --user www-data $name ssh-keygen -N '' -f /var/www/.ssh/id_rsa
docker container exec -ti --user user $name ssh-keygen -N '' -f /home/user/.ssh/id_rsa

ssh-keygen -R $ip
ssh-keyscan $ip >> ~/.ssh/known_hosts
cat ~/.ssh/id_rsa.pub | docker exec -i --user user $name tee -a /home/user/.ssh/authorized_keys

scp my.cnf user@$ip:/home/user/.my.cnf

cat sudoers.d.env|docker exec -i $name tee -a /etc/sudoers.d/env >/dev/null
docker container update --restart unless-stopped $name
docker container exec -ti $name chown user:www-data /usr/lib/cgi-bin/
scp cgi-script/* user@$ip:/usr/lib/cgi-bin/
curl http://$ip/cgi-bin/cgitest.sh
docker container cp html/ apache-a:/var/www/

