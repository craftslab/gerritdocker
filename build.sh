#!/bin/bash

FILE=Dockerfile
NAME=craftslab/gerritdocker
TAG=3.4.0-ubuntu20

docker build --no-cache -f $FILE -t $NAME:$TAG .

#docker inspect $NAME:$TAG > Dockerobjects
