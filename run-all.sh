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
echo "work is starting"
(cd work && ./run.sh)

ipwork=$(cat work/ip-*)
ssh user@$ipwork touch .hushlogin 

others="apache haproxy latex mariadb "
for i in $others;
do
	ip=$(cat "$i"/ip-*)
	ssh user@"$ipwork" "ssh-keyscan $i-a >> .ssh/known_hosts &>/dev/null"
	ssh user@"$ipwork" "cat .ssh/id_rsa.pub" | docker exec -i --user user "$i-a" tee -a /home/user/.ssh/authorized_keys &>/dev/null
done
ssh -t user@$ipwork "for i in \$others; do echo \$i; ssh \$i-a touch .hushlogin; done"

if test -e ~/id_rsa.pub; then
	ssh work-a "tee -a ~/.ssh/authorized_keys" >/dev/null < ~/.ssh/id_rsa.pub
fi
#enable ssh from apache-a to mariadb-a and latex-a

service="latex-a mariadb-a"
docker container exec -ti --user www-data apache-a bash -c "ssh-keyscan $service >>/var/www/.ssh/known_hosts &>/dev/null"
docker container exec --user www-data apache-a cat /var/www/.ssh/id_rsa.pub |docker container exec --user user -i $service tee -a /home/user/.ssh/authorized_keys &>/dev/null


