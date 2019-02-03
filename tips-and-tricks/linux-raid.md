# view raid info

```
cat /proc/mdstat
```

# removing drive from soft raid

https://unix.stackexchange.com/questions/332061/remove-drive-from-soft-raid

```
sudo mdadm /dev/md0 --fail /dev/sdb1
sudo mdadm /dev/md0 --remove /dev/sdb1
sudo mdadm --grow /dev/md0 --raid-devices=1 --force

sudo mdadm /dev/md1 --fail /dev/sdb2
sudo mdadm /dev/md1 --remove /dev/sdb2
sudo mdadm --grow /dev/md1 --raid-devices=1 --force
```
