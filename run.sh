#!/bin/sh
/usr/local/sbin/dnscrypt-proxy --local-address=0.0.0.0:53 --resolver-name=opendns &
sleep 5
/opt/goagent/startlocal
