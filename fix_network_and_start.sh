#!/bin/bash

IFNAME=eth0

ip addr flush dev ${IFNAME}

/usr/sbin/dhclient -v ${IFNAME}

ip route add 192.168.1.0/24 dev ${IFNAME} 
ip route add default via 192.168.1.1

sleep 10

/usr/local/bin/mosca -d /db --http-port 80 --http-bundle --very-verbose 2>&1 >> /mosca.log
