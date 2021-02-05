#!/bin/bash
# Description:
#   pakages.csvで管理されているパッケージをアンインストール
#   引数なしの場合は一括削除
# 
# Args:
#   $1: アンインストールするパッケージ
# Returns:
#   sucess: 0 or failed: 1

. "${DOTPATH}/lib/util.sh"
. "${DOTPATH}/packages/brew.sh"

# 引数チェック
if [[ "$#" -gt 1 ]]; then
    lib::util::err 'Argument specification is 1 or less'
    exit 1
fi

# OSごとに処理を変更
if lib::util::is_osx; then
    # 引数指定がない場合一括削除
    echo "aaa"
    if [[ "$#" -eq 0 ]]; then
        packages::brew::uninstall_all
        exit 0
    fi 
    return 1
else
    # パッケージが未インストールの場合
    if lib::util::has "$1"; then
        lib::util::err "${1} is not installed."
        exit 1
    fi

    brew uninstall "${1}" && exit 1
    exit 1
fi
