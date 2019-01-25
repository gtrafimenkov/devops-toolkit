# Docker image for building linux kernel

## Versions

### 1.1.0

```
quay.io/devops-toolkit/kernel-builder:1.1.0
```

Significant changes:
- GCC 8.2
- added sudo package

### 1.0.1

```
quay.io/devops-toolkit/kernel-builder:1.0.1
```

It contains:
  - all dependencies required to build linux kernel deb packages
  - GCC 7.3 which supports the retpoline feature and thus allows to build kernels
    with Spectre v2 vulnerability mitigation
