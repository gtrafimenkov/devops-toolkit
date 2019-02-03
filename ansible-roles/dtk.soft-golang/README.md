## Install Go lang

This role installs [Golang](https://golang.org/) from a binary package.

### Usage

By default the latest stable version is installed.

You can specify another version using variable `golang_version`.  For example:

```
---
- hosts:
    - testhost
  become: yes
  vars:
    golang_version: "1.10.8"
  roles:
    - gtrafimenkov.golang
```

### Supported Version

- 1.10.x
- 1.11.x

### Supported Platforms

- Linux x64

### License

MIT
