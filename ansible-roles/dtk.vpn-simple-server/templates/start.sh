#!/bin/bash

set -e

docker run \
    -d \
    --name vpn-simple-server \
    -v /opt/vpn-simple-server/data:/etc/openvpn \
    -p 1194:1194/udp \
    --cap-add=NET_ADMIN \
    kylemanna/openvpn
