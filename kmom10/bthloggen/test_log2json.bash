#!/usr/bin/env bash

log_test='test.log'
json_test='./data/test.json'

regex_ip='([0-9]{1,3}\.){3}([0-9]{1,3})'

regex_url='(https?:\/\/(www\.)?([a-zA-Z0-9]+)(\.[a-zA-Z0-9.-]+))'

regex_date='[0-3][1-9]).(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec).([0-9]{4}).([0-9][0-9]:[0-9][0-9]:[0-9][0-9]'

if [[ -f $json_test ]]; then
    echo "File exits"
    rm "$json_test"
    echo "File has been deleted"
fi

# Write regex into JSON format and save into new file
sed -rn 's/.*('"$regex_ip"').*('"$regex_date"').*('"$regex_url"').*/{\n"ip": "\1",\n"day": "\4",\n"month": "\5",\n"time": "\7",\n"url": "\8"\n},/w '"$json_test"'' $log_test

# Add [ to beginning of file
sed -i '1s/^/[\n/' $json_test

# Replace last , with a ]
sed -i '$ s/.$/\n]/' $json_test
