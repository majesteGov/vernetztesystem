#!/bin/bash

containers="apache haproxy mariadb latex work"

for i in $containers; do
	docker container stop "$i-a"	
	docker container rm "$i-ai"
	rm -rf $(docker image ls)
done

rm -rf common
