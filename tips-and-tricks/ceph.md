# Ceph notes

## How to get credentials for adding another monitor

```
ceph auth get mon. -o /etc/ceph/tmp-monkeyrin
ceph mon getmap    -o /etc/ceph/tmp-monmap
```

## CephFS mounting

```
sudo mount -t ceph mon1,mon2,mon3:/ /mnt -o name=admin,secret=CLIENT_ADMIN_SECRET

# mounting subdir
sudo mount -t ceph mon1,mon2,mon3:/subdir /mnt -o name=admin,secret=CLIENT_ADMIN_SECRET

# keeping secret in a file
sudo mount -t ceph mon1,mon2,mon3:/ /mnt -o name=admin,secretfile=/path/to/file/with/secret
```

## Monitoring health

```
ceph status
ceph health
ceph heelth detail
```

## Ceph Development

- http://tracker.ceph.com/projects/ceph/roadmap
- https://github.com/ceph/ceph

- https://github.com/ceph/ceph-container

Some integration with Golang:
- https://github.com/digitalocean/ceph_exporter
- https://github.com/ceph/go-ceph

API:
  - ceph osd df => python script => rados_mon_command ("osd df")
