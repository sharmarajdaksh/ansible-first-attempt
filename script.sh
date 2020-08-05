#!/bin/bash

#
# WARNING : DO NOT USE THIS SCRIPT WITHOUT UNDERSTANDING THE CONSEQUENCES
#

getIP() {
	container=$1
	ipLine=$(docker container inspect $container | grep '"IPAddress"' | head -1)
	ip=$(echo $ipLine | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])')
	echo $ip
} 


{
	docker build -t ubuntu-ssh .

	docker container rm -f ubuntu1 ubuntu2 ubuntu3

	docker run --name ubuntu1 -d ubuntu-ssh
	docker run --name ubuntu2 -d ubuntu-ssh
	docker run --name ubuntu3 -d ubuntu-ssh

} > /dev/null
getIP ubuntu1
getIP ubuntu2
getIP ubuntu3

# AFTER THIS, CONFIGURE EACH OF THESE THREE "SERVERS" (DOCKER CONTAINERS, ACTUALLY) TO ALLOW SSH INTO USING THE PRIVATE KEY ansiblekey
