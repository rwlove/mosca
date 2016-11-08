#!/bin/bash

. settings.conf

[ ! -d logs ] && mkdir logs/
[ ! -f logs/mosca.log ] && touch logs/mosca.log

[ ! -d db ] && mkdir db/

docker run \
       --mac-address="${MAC_ADDRESS}" \
       --privileged \
       -dt \
       -v /etc/localtime:/etc/localtime:ro \
       -v ${PWD}/db:/db \
       -v ${PWD}/logs/mosca.log:/mosca.log \
       -h mosca \
       services/mosca
