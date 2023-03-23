#!/bin/bash

rm -rf common
mkdir common
mkfifo common/io

echo "apache is starting"
(cd apache && ./run.sh) 
echo "haproxy is starting"
(cd haproxy && ./run.sh)
echo "mariadb is starting"
(cd mariadb && ./run.sh) 
echo "latex is starting"
(cd latex && ./run.sh) 
echo "tomcat is starting"
(cd tomcat &&./run.sh)
echo "work is starting"
(cd work && ./run.sh)

others="apache haproxy latex mariadb tomcat"

ipwork=$(cat work/ip-*)
ssh user@$ipwork touch .hushlogin 

for i in $others;
do
	ip=$(cat "$i"/ip-*)
	ssh user@"$ipwork" "ssh-keyscan $i-a >> .ssh/known_hosts 2>/dev/null"
	ssh user@"$ipwork" "cat .ssh/id_rsa.pub" | docker exec -i --user user "$i-a" tee -a /home/user/.ssh/authorized_keys &>/dev/null
done
ssh -t user@$ipwork "for i in $others; do echo \$i; ssh \$i-a touch .hushlogin; done"

if test -e ~/id_rsa.pub; then
	ssh work-a "tee -a ~/.ssh/authorized_keys" >/dev/null < ~/id_rsa.pub
fi
#enable ssh from apache-a to mariadb-a and latex-a tomcat-a

#service="latex-a mariadb-a"
#for i in $service;do
#	docker container exec -ti --user www-data apache-a bash -c "ssh-keyscan $i >>/var/www/.ssh/known_hosts &>/dev/null"
#	docker container exec --user www-data apache-a cat /var/www/.ssh/id_rsa.pub |docker container exec --user user -i $i tee -a /home/user/.ssh/authorized_keys &>/dev/null
#done

docker container exec -ti --user www-data apache-a bash -c 'ssh-keyscan latex-a >>/var/www/.ssh/known_hosts 2>/dev/null'
docker container exec --user www-data apache-a cat var/www/.ssh/id_rsa.pub |docker container exec --user user -i latex-a tee -a /home/user/.ssh/authorized_keys &>/dev/null


