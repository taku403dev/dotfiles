#!/bin/sh

. "${DOTPATH}/resources/devices/ds216j.sh"

# 対象のデバイスにSSH接続する
# $1 対象のデバイス名を指定

if [[ $# != 1 ]]; then
  echo "Usage: The argument is specified incorrectly.
  Specify the target device name in the first argument."
  exit 1
fi

case "_$1" in
  _ds216j ) echo "Connect to ds216js with ssh."; enter_ds216j;;
  *) printf "Target device ${1} does not exist." && exit 1;;
esac
