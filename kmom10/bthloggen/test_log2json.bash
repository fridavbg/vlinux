#!/usr/bin/env bash

log_test='test.log'
json_test='./data/test.json'

regex_ip='([0-9]{1,3}\.){3}([0-9]{1,3})'

regex_url='(https?:\/\/(www\.)?([a-zA-Z0-9]+)(\.[a-zA-Z0-9.-]+))'

regex_day='(?<=\[)[0-3][1-9](?=\/)'
# works with
# sed -rn 's/(?<=\[)[0-3][1-9](?=\/)//p' test.log

regex_month='(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)'

if [[ -f $json_test ]]; then
    echo "File exits"
    rm "$json_test"
    echo "File has been deleted"
fi

# Extract lines with both ip & urls and print in JSON format
sed -rn 's/('"$regex_ip"').*('"$regex_month"').*('"$regex_url"').*/{\n"ip": "\1",\n"day": "\2",\n"month": "\4",\n"time": "Time",\n"url": "\6"\n},/w '"$json_test"'' $log_test

# Add [ to beginning of file
sed -i '1s/^/[\n/' $json_test

# Replace last , with a ]
sed -i '$ s/.$/\]/' $json_test