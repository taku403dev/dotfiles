# FileInfo: npmを管理する

. "${DOTPATH}/lib/util.sh"

# npmで管理するグローバルプレフィックスのパス
readonly declare npm_global_path="${HOME}/.npm-global"

function Packages_Npm_build_path() {
# Summary: npmのセットアップをする
# 
    # npmが存在する場合
    if Lib_Util_has 'npm'; then
        # パーミッションの関係で環境によってはグローバルでインストールできないことがあるため
        # デフォルトのインストール先を変更する
        npm config set prefix "$npm_global_path"
        export PATH="${npm_global_path}/bin:$PATH"
    fi
}
