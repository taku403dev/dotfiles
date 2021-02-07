# FileInfo: npmを管理する

. "${DOTPATH}/lib/util.sh"

function packages::npm::setup() {
# Summary: npmのセットアップをする
# 
    # npmが存在する場合
    if Lib_Util_has 'npm'; then
        # パーミッションの関係で環境によってはグローバルでインストールできないことがある
        # デフォルトのインストール先を変更する
        npm config set prefix "${HOME}/.npm-global"
        export PATH="$HOME/.npm-global/bin:$PATH"
    fi
}
