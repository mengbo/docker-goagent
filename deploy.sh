#!/bin/sh

docker pull mengbo/docker-goagent

ALL_CONTAINER=`docker ps -a |grep docker-goagent | cut -f 1 -d ' '`
for c in $ALL_CONTAINER; do
	docker rm $c
done

# Change this to suit your needs.
#GOAGENT_LISTEN_USERNAME=goagent
#GOAGENT_LISTEN_PASSWORD=goagent
#GOAGENT_GAE_APPID=mengbo-goagent
#GOAGENT_GAE_PASSWORD=tnegaog-obgnem

echo "Enter GoAgent local side proxy username: \c"
read GOAGENT_LISTEN_USERNAME
echo "Enter GoAgent local side proxy password: \c"
read GOAGENT_LISTEN_PASSWORD

echo "Enter GoAgent server side GAE APPID: \c"
read GOAGENT_GAE_APPID
echo "Enter GoAgent server side password: \c"
read GOAGENT_GAE_PASSWORD

DOCKER_VOLUME="-v /usr/local/share/ca-certificates:/usr/local/share/ca-certificates"

DOCKER_RUN_ENV="-e GOAGENT_LISTEN_USERNAME=\"${GOAGENT_LISTEN_USERNAME}\" \
	       -e GOAGENT_LISTEN_PASSWORD=\"${GOAGENT_LISTEN_PASSWORD}\" \
	       -e GOAGENT_GAE_APPID=\"${GOAGENT_GAE_APPID}\" \
	       -e GOAGENT_GAE_PASSWORD=\"${GOAGENT_GAE_PASSWORD}\""

docker run --name docker-goagent --dns=127.0.0.1 -d \
	-p 53:53 -p 53:53/udp -p 8087:8087 \
	$DOCKER_VOLUME $DOCKER_RUN_ENV mengbo/docker-goagent
sleep 10
docker cp docker-goagent:/opt/goagent/local/CA.crt .
