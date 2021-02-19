# FileInfo: npmの管理

. "${DOTPATH}/lib/util.sh"

# npmで管理するグローバルプレフィックスのパス
readonly declare npm_global_path="${HOME}/.npm-global"

function Packages_Npm_configure() {
  # Summary: npmの設定をする
  # Desc: パーミッションの関係でデフォルトルートディレクトリではグローバルインストール時にエラーが発生する可能性があるため変更する
  
  # npmが存在する場合
  if Lib_Util_has 'npm'; then
    npm config set prefix "$npm_global_path"
    export PATH="${npm_global_path}/bin:$PATH"
  fi
}
