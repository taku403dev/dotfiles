#!/bin/bash
# dotfilesディレクトリをデプロイする

source "${DOTPATH}/lib/common.sh"

readonly dotfiles_url='ff'

# dotflesを取得
lib::common::fetch_repository $dotfiles_url
# 取得したレポジトリをホームディレクトリに移動させる
mv 'dotfiles' "$DOTPATH"
# dotfilesディレクトリ内のdotfileにシンボリックリンクを貼る
lib::common::link_dotfiles "$DOTPATH" "$HOME"