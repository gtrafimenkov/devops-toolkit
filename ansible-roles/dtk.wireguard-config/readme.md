Configuration of WireGuard VPN.

Example configuration:

```
wireguard:
  - name: wg0
    ip: 10.200.63.33
    netmask: 255.255.0.0
    config: |
      [Interface]
      ListenPort = 39999
      PrivateKey = {{ lookup('file', inventory_dir + '/../secrets/wireguard-keys/t3/privkey') }}

      # peer t1
      [Peer]
      PublicKey = W4qdgPVf9h4ieTFX4kgTI/RlmhMLpTLFC+7SA/4w3DY=
      AllowedIPs = 10.200.63.31/32
      Endpoint = 192.168.63.31:47851

      # peer t2
      [Peer]
      PublicKey = {{ lookup('file', inventory_dir + '/../secrets/wireguard-keys/t2/pubkey') }}
      AllowedIPs = 10.200.63.32/32
      Endpoint = 192.168.63.32:39518
```
