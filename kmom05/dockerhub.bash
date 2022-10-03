#!/usr/bin/env bash

# DOCKER CLEAN
docker network disconnect dbwebb mazeserver
docker network rm dbwebb
docker stop mazeclient
docker stop mazeserver
docker container rm mazeclient
docker container rm mazeserver

docker network create dbwebb

docker run -d --name mazeserver -p 8080:1337 --net dbwebb fridavbg/vlinux-mazeserver:1.0

docker run -it --name mazeclient --net dbwebb fridavbg/vlinux-mazeclient:1.0

docker stop mazeclient
docker stop mazeserver
docker network rm dbwebb