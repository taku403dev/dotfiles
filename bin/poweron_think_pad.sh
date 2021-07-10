#!/bin/bash
# LAN経由で特定のPCを起動する
# 引数１: 起動するデバイス

. ${DOTPATH}/lib/util.sh
. ${DOTPATH}/resources/thinkpad_x230.sh


# wakeonlanが存在しない場合
if ! Lib_Util_has wakeonlan; then
  brew install wakeonlan || echo 'wakeonlanコマンドがインストール出来ませんでした' &&  exit 1;
  echo 'wakeonlanコマンドのインストール完了しました';
fi

if [[ $# -eq 0 ]]; then
  poweron_thinkpadx230
else
  case "$1" in
    "thinkpad_x230") poweron_thinkpadx230;;
    *) echo "PCが存在しません"; return 1;;
  esac
fi
