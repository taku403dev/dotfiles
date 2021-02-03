#!/bin/bash
# インストール済みのコマンドを一括削除

source ${DOTPATH}/lib/resources/brew_operator.sh
source ${DOTPATH}/lib/util.sh

echo -n 'インストール済みのパッケージを全て削除しますがよろしいですか？ yes/no'
while read answer; do
    case $answer in
        y | Y | yes | YES | Yes ) echo "パッケージをインストールします"; break;;
        n | N | no | NO | No ) echo "処理を中止します"; exit 0;;
        * ) echo "yesかnoを入力してください。";;
    esac
    echo -n 'インストール済みのパッケージを全て削除しますがよろしいですか？ yes/no'
done

# OSごとにパッケージマネージャーが異なるので処理を分ける
if lib::util::is_osx; then
    uninstall_homebrew_all
fi