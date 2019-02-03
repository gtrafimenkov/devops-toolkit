# Linux Security

## How to check if kernel is vulnerable to Meltdown and Spectre

- `grep . /sys/devices/system/cpu/vulnerabilities/*`
- if previous command doesn't return anything, then:
    - either the kernel is old and the system is vulnerable
    - or it is a vendor kernel (e.g. Ubuntu) which may or may not have some mitigations.
      You may try https://github.com/speed47/spectre-meltdown-checker to find if the kernel is vulnerable.
