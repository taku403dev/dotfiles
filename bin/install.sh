#!/bin/bash
# Description:
#   packages.txtで管理されているパッケージをインストールする
#
# Returns:
#   sucess: 0 or failed: 1

. "${DOTPATH}/lib/util.sh"
. "${DOTPATH}/packages/brew.sh"

# 引数チェック
if [[ "$#" -ne 0 ]]; then
  Lib_Util_err 'Argument specification is less'
  exit 1
fi

# OSごとに処理を変更
if Lib_Util_is_osx; then
  packages::brew::install_all && exit 0
  exit 1
fi
