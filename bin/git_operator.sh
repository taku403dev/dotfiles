#!/bin/bash

GIT_REPOSITORIES="${DOTPATH}/git_repositories.csv"
source "$DOTPATH/etc/const.sh"

_check_git(){
  # gitの存在チェック
  
  # gitがインストールされていない場合
  [[ $(which git) ]] || install_package 'git'
}

_get_url(){
  #変数GIT_REPOSITORYESのCSVファイルで管理されているインストール対象コマンドのURLを取得する。
  # args:
  # $1: 取得対象のコマンド
  
  echo $(grep "^${1}," "$GIT_REPOSITORIES" | awk -F, '{print $2}')
}

_get_dir(){
  [[ $(which "${1}") && $(grep "^${1}," "$GIT_REPOSITORIES" | awk -F, '{print $1}') ]] && echo "${HOME}/.${1}"
}

install_clone_by_command(){
  # Summary:
  # 変数 GIT_REPOSITORIESに定義されているCSVファイルを参照し特定のコマンドをセットアップする。
  # args:
  # $1: セットアップ対象のコマンド
  # Description:
  # 詳細は変数 GIT_REPOSITORIESに定義されているCSVファイルを参照：
  # １行目はプロパティなので除外する。２行目以降の各列の意味を下記に記載。
  # column1: セットアップ対象のコマンド
  # column2: 対象のレポジトリURL
  
  git_clone_row= "$(grep $1 ${GIT_REPOSITORIES})"
  dir_path="${HOME}/.$(awk -F, '{print $1}' $git_clone_row)"
  url=$(awk -F, '{print $2}' "$git_clone_row")
  
  # 既にディレクトリが存在する場合
  if [[ -d "$dir_path" ]]; then
    read -p "The $dir_path already exists. Are you sure you want to remove it and install it?\n Please enter yes or no: " input
    case "$input" in
      [yY] | yes | YES | Yes) rm -rf $dir_path;;
      [nN] | no | NO | No) return 0;;
      *) echo "Please enter yes or no."; return 1;;
    esac
  fi
  
  mkdir -p $dir_path
  run "git clone $url $dir_path"
}

install_all_repositories(){
  # Summary:
  # 変数 GIT_REPOSITORIESに定義されているCSVファイルからcloneしインストールする。
  # Description:
  # 詳細は変数 GIT_REPOSITORIESに定義されているCSVファイルを参照：
  # １行目はプロパティなので除外する。２行目以降の各列の意味を下記に記載。
  # column1: セットアップ対象のコマンド
  # column2: 対象のレポジトリURL
  
  while read git_clone_row;
  do
    dir_path="${HOME}/.$(awk -F, '{print $1}' $git_clone_row)"
    url=$(awk -F, '{print $2}' "$git_clone_row")
    # ディレクトリが存在する場合はバックアップを取る
    [[ -d "$dir_path" ]] && mv "$dir_path" "${dir_path}_bk"
    # クローン先のディレクトリを生成
    mkdir "$dir_path"
    run "git clone $url $dir_path"
    # tail -n +2 はCSVの先頭行を取り除く
  done < $(cat "$GIT_REPOSITORIES" | tail -n +2)
}

remove_by_command(){
  # 変数 GIT_REPOSITORIESのCSVファイルで管理されているコマンドを削除する。
  # args:
  # $1: 削除対象のコマンド
}

