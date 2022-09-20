#!/bin/bash

docker run -p 8080:80 --name mysite -v "$(pwd)/$1":/var/www/vhosts/mysite.vlinux.se --add-host mysite.vlinux.se:127.0.0.1 fridavbg/vlinux-vhost:1.0