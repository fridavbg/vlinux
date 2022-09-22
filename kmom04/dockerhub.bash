#!/bin/bash

docker run -p 1337:1337 -d -v "$(pwd)/$1:"/server/data fridavbg/vlinux-server:1.0