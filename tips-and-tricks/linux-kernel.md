https://www.kernel.org/

## How to setup close to mainline kernel to Ubuntu

https://wiki.ubuntu.com/Kernel/MainlineBuilds

## How to build vanilla kernel for Debian

See
  - https://kernel-handbook.alioth.debian.org/ch-common-tasks.html#s-kernel-org-package
  - https://wiki.debian.org/BuildingKernelFromUpstreamSources

Build script:

```
sudo apt-get update
sudo apt-get build-dep linux -y
sudo apt-get install -y build-essential fakeroot

wget https://cdn.kernel.org/pub/linux/kernel/v4.x/linux-4.15.2.tar.xz
tar -xaf linux-4.15.2.tar.xz
cd linux-4.15.2
cp /boot/config-4.9.0-5-amd64 ./.config

time make -j4 deb-pkg
```
