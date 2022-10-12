#!/usr/bin/env bash

# ip_adresses_regex = '/([0-9]{1,3}\.){3}[0-9]{1,3}/p'
# url_regex = '/(http|ftp|https):\/\/([\w_-]+(?:(?:\.[\w_-]+)/p'

# sed -n -E '(http|ftp|https):\/\/([\w_-]+(?:(?:\.[\w_-]+)' <access-50k.log

sed -n -E '/([0-9]{1,3}\.){3}[0-9]{1,3}/p' | cut -d ' ' -f 1 <access-50k.log