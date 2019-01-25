#!/bin/bash

set -e

docker run -v /opt/vpn-simple-server/data:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u udp://{{vpn_simple_server.address}}
docker run -v /opt/vpn-simple-server/data:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki
