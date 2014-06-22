#!/bin/bash
set -e

GOAGENT_GAE_PASSWORD=${GOAGENT_GAE_PASSWORD}

sed "s/^__password__ =.*$/__password__ = '$GOAGENT_GAE_PASSWORD'/" \
	/usr/local/src/goagent/server/gae/gae.py \
	> /opt/goagent/server/gae/gae.py
(cd /opt/goagent/server; python uploader.zip)
