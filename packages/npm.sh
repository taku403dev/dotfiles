# FileInfo: npmの管理

. "${DOTPATH}/lib/util.sh"

# npmで管理するグローバルプレフィックスのパス
readonly declare npm_global_path="${HOME}/.npm-global"

function Packages_Npm_build_path() {
  # Summary: npm -g install時のデフォルトルートパスを変更する
  # Detail: パーミッションの関係で環境によってはグローバルでインストールできないことがあるためホームディレクトリ下に作成する
  
  # npmが存在する場合
  if Lib_Util_has 'npm'; then
    npm config set prefix "$npm_global_path"
    export PATH="${npm_global_path}/bin:$PATH"
  fi
}
