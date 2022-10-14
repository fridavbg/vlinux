#!/usr/bin/env bash

file='access-50k.log'
test_log='test.log'

regex_ip='([0-9]{1,3}\.){3}([0-9]{1,3})'
regex_url='(https?:\/\/(www\.)?([a-zA-Z0-9]+)(\.[a-zA-Z0-9.-]+))'

# grep $regex_ip_url $file | awk -F' ' '{print { ip: $1, url: $2}}'

sed -rn 's/.*([0-9]{1,3}\.){3}([0-9]{1,3}).*(https?:\/\/(www\.)?([a-zA-Z0-9]+)(\.[a-zA-Z0-9.-]+)).*/{\n"ip": "\1\2",\n"url": "\3" \n}/p' $test_log

# grep -oP $regex_ip.*$regex_url.* $file | awk -F' ' '{print $1}' 