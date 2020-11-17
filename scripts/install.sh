#!/bin/sh

apt update

apt install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common \
    unzip \
    openvswitch-switch \

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

apt update
apt-cache policy docker-ce
apt install -y docker-ce

ovs-vsctl --may-exist add-br br-int
ovs-vsctl --may-exist add-br br-mgmt

ip address add 172.31.0.254/24 dev br-mgmt
ip link set br-mgmt up


