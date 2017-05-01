#!/bin/bash

while ! ping -c 1 brain; do
    echo "(mosca) Waiting for brian - network interface might be down..."
    sleep 1
done

#/usr/local/bin/mosca -d /db -p --http-bundle --very-verbose 2>&1 >> /mosca.log
/usr/local/bin/mosca -d /db --very-verbose 2>&1 >> /mosca.log
