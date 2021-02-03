#!/bin/bash

THINKPADX230_MAC_ADDRESS='3c:97:e:e8:52:64'

# Thinkpad x230のローカルIPアドレスを取得する
get_ip_thinkpad_x230() {
    tinkpad_x230_ip=$(arp -a | grep "$THINKPADX230_MAC_ADDRESS" | grep ifscope | awk '{print $2}' | sed 's/^(\(.*\))$/\1/') \
    || return 1

    echo $thinkpad_x230_ip
}

# thinkpad x230の電源をオンにする
poweron_thnikpadx230() {
    wakeonlan $THINKPADX230_MAC_ADDRESS || return 1
}
