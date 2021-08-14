#!/bin/bash

function run_local_dev {
    local ip_regex="192\.[0-9]*\.[0-9]*\.[0-9]*"
    local my_local_ip=$(ifconfig wlp2s0 | grep -o -e "inet $ip_regex" | grep -o -e "$ip_regex")
    echo $my_local_ip
    FADO_EXPO_HTTP_URL="http://$my_local_ip:4000/api" FADO_EXPO_WS_URL="ws:$my_local_ip:4000/socket" expo start
}

run_local_dev
