#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

ovs-docker del-ports br-int ctr
ovs-docker del-ports br-mgmt cgw01
ovs-docker del-ports br-mgmt cgw02

docker stop ctr
docker stop cgw01
docker stop cgw02
