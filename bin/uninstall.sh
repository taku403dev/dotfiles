#!/bin/bash
# FileInfo: パッケージをアンインストールする
#   Desc: pakages.txtで管理されているパッケージを一括アンインストール。引数指定が指定された場合は削除するパッケージを指定。
# 
# Args:
#   $1: アンインストールするパッケージ
# Returns:
#   0: 成功
#   1: 指定したパッケージが未インストール

. "${DOTPATH}/lib/util.sh"
. "${DOTPATH}/packages/brew.sh"

# 引数チェック
if [[ "$#" -gt 1 ]]; then
    Lib_Util_err 'Argument specification is 1 or less'
    exit 1
fi

# OSごとに処理を変更
if Lib_Util_is_osx; then
    # 引数指定がない場合一括削除
    if [[ "$#" -eq 0 ]]; then
        packages::brew::uninstall_all
    fi 
else
    # パッケージがインストールされていない場合
    if Lib_Util_has "$1"; then
        Lib_Util_err "${1} is not installed."
        exit 1
    fi

    brew uninstall "${1}" && exit 0
fi
