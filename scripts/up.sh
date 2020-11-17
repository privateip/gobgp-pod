#!/bin/bash

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

docker run -d --name ctr -it --network none --rm -v `pwd`/conf/ctr:/etc/gobgp --privileged gobgp:latest
docker run -d --name cgw01 -it --network none --rm -v `pwd`/conf/cgw01:/etc/gobgp --privileged gobgp:latest
docker run -d --name cgw02 -it --network none --rm -v `pwd`/conf/cgw02:/etc/gobgp --privileged gobgp:latest

ovs-docker add-port br-mgmt eth0 ctr --ipaddress=172.31.0.1/24 --gateway=172.31.0.254
ovs-docker add-port br-mgmt eth0 cgw01 --ipaddress=172.31.0.2/24 --gateway=172.31.0.254
ovs-docker add-port br-mgmt eth0 cgw02 --ipaddress=172.31.0.3/24 --gateway=172.31.0.254

ovs-docker add-port br-int eth1 ctr --ipaddress=198.18.0.1/24
ovs-docker add-port br-int eth1 cgw01 --ipaddress=198.18.0.2/24
ovs-docker add-port br-int eth1 cgw02 --ipaddress=198.18.0.3/24

ovs-docker set-vlan br-int eth1 ctr 10
ovs-docker set-vlan br-int eth1 cgw01 10
ovs-docker set-vlan br-int eth1 cgw02 10
