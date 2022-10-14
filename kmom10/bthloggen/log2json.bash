#!/usr/bin/env bash

file='access-50k.log'

regex_ip='([0-9]{1,3}\.){3}([0-9]{1,3})'
regex_url='(https?:\/\/(www\.)?([a-zA-Z0-9]+)(\.[a-zA-Z0-9.-]+))'

# grep $regex_ip_url $file | awk -F' ' '{print { ip: $1, url: $2}}'

# sed -rn 's/'$regex_ip'.*'$regex_url'/{"ip": "\1","url": "\2"}/p'

grep -oP $regex_ip.*$regex_url.* $file | awk -F' ' '{print $1}' 

