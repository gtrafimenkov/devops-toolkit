# GitLab CI

## How to register new runner

### Shell executor for building docker images

This executor will be able to build docker images.

*Security risk*: access to the docker effectively gives any running job
root access to the system.

- install gitlab-runner
- register a runner:

```
sudo su -
export CI_SERVER_URL=https://gitlab.com/
export REGISTRATION_TOKEN=Z4GjC5GDrXFBKVbip472
export RUNNER_EXECUTOR=shell
export RUNNER_NAME=shell-executor
export RUNNER_TAG_LIST=shell
gitlab-runner register -n
```

- install docker
- allow gitlab-runner runner call docker without sudo:

```
sudo usermod -aG docker gitlab-runner
```

### Docker executor

```
sudo su -
export CI_SERVER_URL=https://gitlab.com/
export REGISTRATION_TOKEN=wppikrU1FA-RLxBWuQF2
export RUNNER_EXECUTOR=docker
export RUNNER_NAME=docker-executor
export RUNNER_TAG_LIST=docker
gitlab-runner register -n --docker-image ubuntu:18.04
```
