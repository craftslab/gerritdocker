#!/bin/bash

FILE=Dockerfile
NAME=craftslab/gerritdocker
TAG=3.3.2-ubuntu20

pushd ubuntu/20
docker build --no-cache -f $FILE -t $NAME:$TAG .
popd

#docker inspect $NAME:$TAG > Dockerobjects
