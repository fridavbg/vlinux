echo 
"docker run -it -p 8080:80 -v $(pwd)/mysite.vlinux.se:/var/www/vhosts/mysite.vlinux.se --add-host mysite.vlinux.se:127.0.0.1 fridavbg/vlinux-vhost:1.0"