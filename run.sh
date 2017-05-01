#!/bin/bash

. settings.conf

[ ! -d logs ] && mkdir logs/
[ ! -f logs/mosca.log ] && touch logs/mosca.log

[ ! -d db ] && mkdir db/

docker run \
       --network="none" \
       --privileged \
       -dt \
       -v /etc/localtime:/etc/localtime:ro \
       -v ${PWD}/db:/db \
       -v ${PWD}/logs/mosca.log:/mosca.log \
       -p ${LISTEN_PORT}:${LISTEN_PORT} \
       -h mosca \
       services/mosca

add_contianer_to_network.sh -n mosca -b br0 -m ${MAC_ADDRESS}
