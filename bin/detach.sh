#!/bin/bash
# dotfilesディレクトリのシンボリックを解除する

# 引数判定
if [[ "$#" -gt 1 ]]; then
  echo 'Usage: The argument should be 1 or less.'
  exit 1
fi

# フォルダ名取得
dotfiles_dir="${1:-dotfiles}"

# dotfilesディレクトリの存在チェック
if [[  ! -d "${HOME}/${dotfiles_dir}" ]]; then
  echo "Cannot break the symbolic link because $dotfiles_dir does not exist"
  exit 1
fi

cd "${HOME}/${dotfiles_dir}"

# リンクの解除
for f in .??*
do
  # リンク先のリンク先とソース元が不一致の場合
  [[ $(readlink "${HOME}/${f}") = "${HOME}/$dotfiles_dir/${f}" ]] || continue
  
  unlink "${HOME}/${f}"
done


cd $cnt_dir
exec $SHELL -l
