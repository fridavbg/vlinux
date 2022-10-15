#!/usr/bin/env bash

log_file='access-50k.log'
log_test='test.log'
json_file='./data/log.json'

regex_ip='([0-9]{1,3}\.){3}([0-9]{1,3})'

regex_url='(https?:\/\/(www\.)?([a-zA-Z0-9]+)(\.[a-zA-Z0-9.-]+))'

if [[ -f $json_file ]]; then
    echo "File exits"
    rm "$json_file"
    echo "File has been deleted"
fi

# Extract lines with both ip & urls and print in JSON format
sed -rn 's/('"$regex_ip"').*('"$regex_url"').*/{\n"ip": "\1",\n"url": "\4" \n},/w '"$json_file"'' $log_file

# Add [ to beginning of file
sed -i '1s/^/[\n/' $json_file

# Replace last , with a ]
sed -i '$ s/.$/\]/' $json_file
