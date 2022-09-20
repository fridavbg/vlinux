#!/bin/bash

docker run -p 1337:1337 -v "$(pwd)/data":/server/data fridavbg/vlinux-server:1.0