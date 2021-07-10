#!/bin/bash

THINKPADX230_MAC_ADDRESS='3c:97:e:e8:52:64'

# Thinkpad x230のローカルIPアドレスを取得する
get_ip_thinkpad_x230() {
  ip_address=$(arp -a | grep "$THINKPADX230_MAC_ADDRESS" | grep ifscope | awk '{print $2}' | sed 's/^(\(.*\))$/\1/') \
  || return 1

  echo "$ip_address"
}



# thinkpad x230の電源をオンにする
poweron_thinkpadx230() {
  wakeonlan $THINKPADX230_MAC_ADDRESS || return 1
}
