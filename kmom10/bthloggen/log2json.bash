#!/usr/bin/env bash

# ip_adresses_regex = '/(([0-9]{1,3}\.){3}([0-9]{1,3}))/p'
# url_regex = '/[A-Za-z]+:\/\/[A-Za-z0-9\-_]+\.[A-Za-z0-9\-_:%&;\?\#\/.=]+/p'

# sed -n -E '(http|ftp|https):\/\/([\w_-]+(?:(?:\.[\w_-]+)' <access-50k.log

sed -n -E '/([0-9]{1,3}\.){3}[0-9]{1,3}/p' | cut -d ' ' -f 1 <access-50k.log