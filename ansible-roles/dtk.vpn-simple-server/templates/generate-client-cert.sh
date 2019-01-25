#!/bin/bash

set -e

CLIENT_NAME=${1:?Client name is not defined}

mkdir -p /opt/vpn-simple-server/client-certs

if test -f /opt/vpn-simple-server/client-certs/$CLIENT_NAME.ovpn; then
    echo "Client certificate $CLIENT_NAME.ovpn already exists"
    exit 10
fi

docker run -v /opt/vpn-simple-server/data:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full $CLIENT_NAME nopass
docker run -v /opt/vpn-simple-server/data:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient $CLIENT_NAME >/opt/vpn-simple-server/client-certs/$CLIENT_NAME.ovpn
