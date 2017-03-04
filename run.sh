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
       -p ${LISTEN_PORT}:${LISTEN_PORT} \
       -h mosca \
       services/mosca

for zone in "external" "trusted" ; do
    ##
    # Consider removing forwarding rule in ./stop.sh script
    ##
    echo "Current Port Forwarding rules for the '${zone}' zone. Mosca cares about port ${LISTEN_PORT}"
    firewall-cmd --list-forward-ports --zone ${zone}

    if [ `firewall-cmd --list-forward-ports --zone ${zone} | grep -c ${LISTEN_PORT}` -eq 0 ] ; then
	echo "Forwarding '${zone}' zone port ${LISTEN_PORT}/tcp to 192.168.3.28"
	firewall-cmd --zone=${zone} --add-forward-port=port=${LISTEN_PORT}:proto=tcp:toaddr=192.168.3.28
    fi
done
