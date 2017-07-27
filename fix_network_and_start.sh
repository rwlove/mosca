#!/bin/bash

IFNAME=eth0

ip addr flush dev ${IFNAME}

/usr/sbin/dhclient -v ${IFNAME}

ip route add default via 192.168.1.1

sleep 10

#/usr/local/bin/mosca -d /db -p --http-bundle --very-verbose 2>&1 >> /mosca.log
/usr/local/bin/mosca -d /db --very-verbose 2>&1 >> /mosca.log
