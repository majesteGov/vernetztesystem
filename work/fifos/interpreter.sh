#!/bin/bash

echo "Content-Type: text/plain"
echo 
output=$(cat /common/io)
daten=%(date +%N)
echo "passt from cgi"

echo "$daten" >> /common/queue.txt

while read line;do 
	line=${line//'\r'}

	if ["$line"==" " ];then
		break;
	fi
done
./sender.sh
	
