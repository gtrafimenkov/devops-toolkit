# Simple OpenVPN server

It uses [kylemanna/openvpn](https://hub.docker.com/r/kylemanna/openvpn).

## How to use

- init OpenVPN server: `sudo ./init.sh`

- start it: `sudo ./start.sh`

- generate a client certificate: `sudo ./generate-client-cert.sh`

- copy the client certificate file from /opt/vpn-simple-server/client-certs to the client machine

- from the client machine connect to the vpn server: `sudo openvpn path_to_ovpn_file`

## How automatically connect to the vpn server on boot

```
sudo install -o root -m 400 CLIENTNAME.ovpn /etc/openvpn/CLIENTNAME.conf
```

## References

- https://hub.docker.com/r/kylemanna/openvpn
- https://www.digitalocean.com/community/tutorials/how-to-run-openvpn-in-a-docker-container-on-ubuntu-14-04
