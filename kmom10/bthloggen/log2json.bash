#!/usr/bin/env bash

log_file='access-50k.log'
log_test='test.log'
json_file='./data/log.json'

regex_ip='([0-9]{1,3}\.){3}([0-9]{1,3})'
regex_url='(https?:\/\/(www\.)?([a-zA-Z0-9]+)(\.[a-zA-Z0-9.-]+))'

sed -rn 's/(([0-9]{1,3}\.){3}([0-9]{1,3})).*(https?:\/\/(www\.)?([a-zA-Z0-9]+)(\.[a-zA-Z0-9.-]+)).*/{\n"ip": "\1",\n"url": "\4" \n},/w ./data/log.json' $log_test

sed -i '1s/^/[\n/' $json_file

sed -i '$ s/.$/\]/' $json_file