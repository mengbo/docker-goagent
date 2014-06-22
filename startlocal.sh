#!/bin/bash
set -e

GOAGENT_LISTEN_USERNAME=${GOAGENT_LISTEN_USERNAME:-"goagent"}
GOAGENT_LISTEN_PASSWORD=${GOAGENT_LISTEN_PASSWORD:-"goagent"}
GOAGENT_GAE_APPID=${GOAGENT_GAE_APPID:-"docker-goagent"}
GOAGENT_GAE_PASSWORD=${GOAGENT_GAE_PASSWORD:-"docker-goagent"}

changeini()
{
	file=$1
	sec=$2
	opt=$3
	val=$4
	sed -i "/^\[$sec\]/,/^\[.*\]/ s/^$opt[ \t]*=.*/$opt = $val/" $file
}

cat /usr/local/src/goagent/local/proxy.ini > /opt/goagent/local/proxy.ini
cat /opt/goagent/local/proxy.local.ini >> /opt/goagent/local/proxy.ini
changeini /opt/goagent/local/proxy.ini listen username $GOAGENT_LISTEN_USERNAME
changeini /opt/goagent/local/proxy.ini listen password $GOAGENT_LISTEN_PASSWORD
changeini /opt/goagent/local/proxy.ini gae appid $GOAGENT_GAE_APPID
changeini /opt/goagent/local/proxy.ini gae password $GOAGENT_GAE_PASSWORD

(cd /opt/goagent/local; python proxy.py)
