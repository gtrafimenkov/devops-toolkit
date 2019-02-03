### Remove unnamed images

```
docker rmi $(docker images  | grep '<none>' | awk -- '{print $3}')
```

### Remove all images not associated with containers

```
docker image prune -af
```

### Remove all containers

```
docker rm $(docker ps -aq)
```
