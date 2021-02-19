#!/bin/bash
# FileInfo: OSごとに異なるデプロイを実行
#
# Exits:
#   0: デプロイ成功
#   1: デプロイ失敗

. "${DOTPATH}/lib/util.sh"
. "${DOTPATH}/os/osx.sh"

# macの場合
if Lib_Util_is_osx; then
  Lib_Util_output "Build the environment for osx."
  os::osx:deploy || exit 1
  Lib_Util_output "Succefully in building osx environment."
fi
