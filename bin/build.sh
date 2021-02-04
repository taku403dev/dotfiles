#!/bin/bash
# dotfilesを利用するための起動スクリプト
# dotfilesをレポジトリからダウンロードしシンボリックを貼る

# ダウンロード先のurl
readonly tarball='https://github.com/taku403dev/dotfiles/archive/master.tar.gz'
readonly giturl='https://github.com/taku403dev/dotfiles.git'

# 引数判定
if [[ "$#" -gt 1 ]]; then
    echo 'Usage: The argument should be 1 or less.'
    exit 1
fi

# フォルダ名
dotfiles_dir="${1:-dotfiles-master}"

cd "$HOME"

# dotfilesディレクトリが存在する場合
if [[  -d "${home}/${dotfiles_dir}" ] || [ -d "${HOME}/dotfiles" ]]; then
    while :
    do
        echo "cannot download because the ${dotfiles_dir} exists. \n remove a ${dotfiles_dir}?  yes/no ) " 
        read answer
        case $answer in
            y | yes | Yes )
                rm -rf "${HOME}/${dotfiles_dir}"
                echo "Removed a ${HOME}/${dotfiles_dir}";
                break;;

            n | no | No )
                exit 1;;

            * ) echo 'Please enter yes or no.';;
        esac
    done
fi

# gitが存在する場合
if [[ $(which git) ]]; then

    dotfiles_dir='dotfiles'
    git clone "$giturl"

    # git cloneが失敗した場合
    if [[ $? -ne 0 ]]; then
        if [[ $(uname -s) = 'Darwin' ]]; then
            # git を利用するためxcode-selectを導入
            xcode-select --install || exit 1
        fi
        exit 1
    fi

# curlかwgetにtarballを渡す
elif  [[ $(which curl) ]]; then
    curl -L "$tarball" | tar zxv

elif [[ $(which wget) ]]; then
    wget -O "$tarball" | tar zxv
else 
    echo 'Requires command gti or curl or wget.'
    exit 1
fi 

# フォルダをユーザーディレクトリ下に移動
mv "${dotfiles_dir}" "${HOME}"

# dotfilesディレクトリに移動しシンボリックリンクを貼る
cnt_dir=$(pwd)
cd "${HOME}/${dotfiles_dir}"

# リンクを貼る
for f in .??*
do
    # 除外ファイル
    [[ "$f" = '.git' \
        || "$f" = '.DS_Store' \
        || "$f" = '.Trash' \
        || "$f" = '.vscode' \
        || "$f" = '.vscode-insiders' \
        || "$f" = '.CFUserTextEncoding' \
    ]] && continue

    # リンク対象が存在する場合
    if [[ -f "${HOME}/${f}" || -d "${HOME}/${f}" ]]; then
       echo "failed [ $(date "+%Y-%m-%dT%H:%M:%S") ] Cannot link because the ${HOME}/${f} exists." >> '/tmp/init.log'
       continue
    fi

    ln -snfv "${HOME}/${dotfiles_dir}/${f}" "${HOME}/${f}"
done


cd $cnt_dir
exec $SHELL -l
