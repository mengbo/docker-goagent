#!/bin/bash
set -e

GOAGENT_LISTEN_USERNAME=${GOAGENT_LISTEN_USERNAME}
GOAGENT_LISTEN_PASSWORD=${GOAGENT_LISTEN_PASSWORD}
GOAGENT_GAE_APPID=${GOAGENT_GAE_APPID}
GOAGENT_GAE_PASSWORD=${GOAGENT_GAE_PASSWORD}

changeini()
{
	file=$1
	sec=$2
	opt=$3
	val=$4
	sed -i "/^\[$sec\]/,/^\[.*\]/ s/^$opt[ \t]*=.*/$opt = $val/" $file
}

cat /usr/local/src/goagent/local/proxy.ini > /opt/goagent/local/proxy.ini
#cat /opt/goagent/local/proxy.user.ini >> /opt/goagent/local/proxy.ini
changeini /opt/goagent/local/proxy.ini listen username $GOAGENT_LISTEN_USERNAME
changeini /opt/goagent/local/proxy.ini listen password $GOAGENT_LISTEN_PASSWORD
changeini /opt/goagent/local/proxy.ini gae appid $GOAGENT_GAE_APPID
changeini /opt/goagent/local/proxy.ini gae password $GOAGENT_GAE_PASSWORD

CA_FILE=/usr/local/share/ca-certificates/GoAgent.crt
if [ -f $CA_FILE ]; then
	cp -f $CA_FILE /opt/goagent/local/CA.crt
fi

(cd /opt/goagent/local; python proxy.py)
