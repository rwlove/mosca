#!/bin/bash

docker stop `docker ps | grep services/mosca | cut -d ' ' -f 1`
