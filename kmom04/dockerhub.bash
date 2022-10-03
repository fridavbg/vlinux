#!/bin/bash

DBWEBB_PORT=${DBWEBB_PORT:-8080}

docker run -p "$DBWEBB_PORT":1337 -d --name myserver -v "$(pwd)/$1:"/server/data fridavbg/vlinux-server:1.0