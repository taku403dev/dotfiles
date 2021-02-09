#!/bin/bash
# FileInfo: ホームディレクトリにdotfilesディレクトリ下に存在する.ファイルのシンボリックリンクを貼る

# 引数チェック
if [[ "$?" -ne 0 ]]; then
  echo 'No arguments required.'
  exit 1
fi

# ディレクトリ名取得
dotfiles_dir='dotfiles'

# dotiflesディレクトリの存在チェック
if [[ ! -d "${HOME}/${dotfiles_dir}" ]]; then
  echo "${HOME}/${dotfiles_dir} does not exist"
  exit 1
fi

# リンクを貼るため移動
declare current_dir=$(pwd)
cd "${HOME}/${dotfiles_dir}"

# ディレクトリに移動できない場合
if [[ $? -ne 0 ]]; then
  echo "Could not move to ${HOME}/${dotfiles_dir}."
  exit 1
fi

# リンクを貼る
for f in .??*
do
  # 除外ファイル
  [[ "$f" = '.git' \
      || "$f" = '.DS_Store' \
      || "$f" = '.Trash' \
      || "$f" = '.vscode' \
      || "$f" = '.vscode-insiders' \
      || "$f" = '.env' \
      || "$f" = '.shellspec' \
  ]] && continue
  
  # リンク対象が存在するかチェック
  if [[ -d "${HOME}/${f}" || -f "${HOME}/${f}" ]]; then
    echo "Couldn't put the link because the ${HOME}/${f} exists"
    continue
  fi
  
  ln -snfv "${HOME}/${dotfiles_dir}/${f}" "${HOME}/${f}"
done

cd "$current_dir"
exec $SHELL -l
