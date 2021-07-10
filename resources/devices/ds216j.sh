#!/bin/sh

# NAS操作

DS216J_MAC_ADDRESS='0:11:32:74:d:2c'

# ds216jのローカルアドレスを取得する
get_ip_ds216j() {
  ip_address=$(arp -a | grep "0:11:32:74:d:2c" | grep 'ifscope' | awk '{print $2}' | sed 's/^(\(.*\))$/\1/') \
  || return 1

  echo "$ip_address"
}

# ds216サーバーにssh接続で入る
enter_ds216j() {
  ssh -i "$DS216_PASSWORD" "${USER_NAME}@$(get_ip_ds216j)" -p 22 \
  || echo "ds216サーバーにssh接続失敗しました" &&  return 1;
}
