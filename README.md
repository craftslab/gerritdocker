# gerritdocker

[![Docker](https://img.shields.io/docker/pulls/craftslab/gerritdocker)](https://hub.docker.com/r/craftslab/gerritdocker)
[![License](https://img.shields.io/github/license/craftslab/gerritdocker.svg?color=brightgreen)](https://github.com/craftslab/gerritdocker/blob/master/LICENSE)
[![Tag](https://img.shields.io/github/tag/craftslab/gerritdocker.svg?color=brightgreen)](https://github.com/craftslab/gerritdocker/tags)



## Introduction

*Gerrit Docker* is the Dockerfile for Gerrit Docker built on Ubuntu.



### Build

```bash
./build.sh
```



### Deploy

```bash
echo "FROM craftslab/gerritdocker:latest" > onbuild

docker pull craftslab/gerritdocker:latest
docker build \
  --build-arg GERRIT_NAME=gerrit \
  --build-arg GERRIT_UID=`id -u` \
  --build-arg GERRIT_GID=`id -g` \
  --no-cache -f onbuild -t craftslab/gerritdocker:new .

rm -f onbuild
```



### Init

```bash
# The external filesystem needs to be initialized with gerrit.war beforehand:
# All-Projects and All-Users Git repositories created in Gerrit
# System Group UUIDs created in Git repositories
# The initialization can be done as a one-off operation before starting all containers.
./init.sh
```



### Run

```bash
# Uncomment the command: init option in docker-compose.yaml
# and run Gerrit with docker-compose in foreground.
./run.sh

# Comment out the command: init option in docker-compose.yaml
# and start all the docker-compose nodes
./run.sh
```



### Reference

- [gerritbuild](https://github.com/craftslab/gerritbuild)
- [gerritdeploy](https://github.com/craftslab/gerritdeploy)
- [Gerrit Docker](https://hub.docker.com/r/gerritcodereview/gerrit)
- [Gerrit Dockerfile](https://github.com/GerritCodeReview/docker-gerrit)
