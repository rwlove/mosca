#!/bin/bash

. settings.conf


for zone in "external" "trusted" ; do
    ##
    # Note that creation of the port forwarding (firewalld) rule is in the ./start.sh script
    ##
    echo "Current Port Forwarding rules for the '${zone}' zone. Mosca cares about port ${LISTEN_PORT}"
    firewall-cmd --list-forward-ports --zone ${zone}

    if [ `firewall-cmd --list-forward-ports --zone ${zone} | grep -c ${LISTEN_PORT}` -gt 0 ] ; then
	echo "Removing forwarding for '${zone}' zone port ${LISTEN_PORT}/tcp to 192.168.3.28"
	firewall-cmd --zone=${zone} --remove-forward-port=port=${LISTEN_PORT}:proto=tcp:toaddr=192.168.3.28
    fi
done

firewall-cmd --zone=trusted --remove-masquerade

docker stop `docker ps | grep services/mosca | cut -d ' ' -f 1`
