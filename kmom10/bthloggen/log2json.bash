#!/usr/bin/env bash

file='access-50k.log'

regex_ip='([0-9]{1,3}\.){3}([0-9]{1,3})'
regex_url='([A-Za-z]+:\/\/[A-Za-z0-9\-_]+\.[A-Za-z0-9\-_:%&;\?\#\/.=]+)'

# regex_ip_url = (([0-9]{1,3}\.){3}([0-9]{1,3}))||([A-Za-z]+:\/\/[A-Za-z0-9\-_]+\.[A-Za-z0-9\-_:%&;\?\#\/.=]+)

# sed -n '/'$regex_ip_url'/p' | cut -d ' ' -f 1 <access-50k.log

# grep $regex_ip_url $file | awk -F' ' '{print { ip: $1, url: $2}}'

grep -oP $regex_url $file

