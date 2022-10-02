#!/usr/bin/env bash

# DOCKER CLEAN
docker network rm dbwebb
docker stop mazeclient
docker stop mazeserver
docker container rm mazeclient
docker container rm mazeserver

# - [x]  Skapa ett nätverk med namnet `dbwebb`.

docker network create dbwebb

# - [x]  Starta upp båda kontainrarna med rätt options.

# - [x]  Servern ska även kunna nås via webbläsaren och port 8080. (localhost:8080)

# - [x]  Båda containrarna ska ha egna namn.

# - [x]  Server-containern ska köras i bakgrunden.

docker run -d --name mazeserver -p 8080:1337 --net dbwebb fridavbg/vlinux-mazeserver:1.0

docker run -it --name mazeclient --net dbwebb fridavbg/vlinux-mazeclient:1.0

# - [x]  Klienten ska använda serverns namn. Du behöver då byta ut “localhost” i skriptet mot namnet du ger servern.
# curl -s "mazeserver:1337/"

# - [x]  Klient-containern ska starta i Bash och i den arbetsmappen du har skriptet i.

# - [x]  Stoppa den/de containrar som är igång och ta bort nätverket.
# docker stop mazeclient
# docker stop mazeserver
# docker rm dbwebb