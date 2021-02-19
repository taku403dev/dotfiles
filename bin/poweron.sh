#!/bin/bash
#!/bin/bash
# LAN経由で特定のPCを起動する
# 引数１: 起動するPC名

. ${DOTPATH}/lib/util.sh
. ${DOTPATH}/packages/thinkpad_x230.sh

# WN-AC1167GR_NIC_MAC_ADDRESS='18:3e:ef:bb:85:c0'
DEFAULT_GATEWAY_SOFTBANK_NIC_MAC_ADDRESS='90:4c:e5:28:98:37'


# wakeonlanが存在しない場合
if ! Lib_Util_has wakeonlan; then
  echo 'wakeonlanコマンドが存在しないため実行できません';
  exit 1
fi

if [[ $# -eq 0 ]]; then
  poweron_thinkpadx230
else
  case "$1" in
    "thinkpad_x230") poweron_thinkpadx230;;
    *) echo "PCが存在しません"; return 1;;
  esac
fi
