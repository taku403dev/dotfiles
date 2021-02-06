# FileInfo: Homebrewを操作する

# ライブラリ
. ${DOTPATH}/lib/util.sh


function packages::brew::setup_arm64() {
# Summary: Homebrewをインストールする(M1 chip version)
# 
# Returns:
#   0: インストール処理の成功
#   1: Homebrewがインストール済み

    # 移動するので現在パスの位置を記憶
    local declare current_dir=$(pwd)

    # Homebrewがインストール済みの場合
    if Lib_Util_has brew; then
        Lib_Util_err "Homebrewはインストール済です。"
        return 1
    fi

    # brewの実行ファイルが存在しない場合
    if [[ ! -f /opt/homebrew/bin/brew ]]; then
        cd /opt
        sudo mkdir homebrew
        sudo chown $USER /opt/homebrew
        curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
        cd "$current_dir"
    fi

    # インストール後、環境変数にパスが通っていない場合
    if ! Lib_Util_has brew ; then
        echo 'export PATH=/opt/homebrew/bin:$PATH' >> "${HOME}/.zshrc"
        source "${HOME}/.zshrc"
    fi
    
    # 更新
    brew update
    return 0
}

function packages::brew::setup_x86_64() {
# Summary: Homebrewをインストールする。(x86 amd64 version)
# 
# Returns:
#   0: インストール処理に成功
#   1: インストール済み、インストール失敗

    # インストール済みの場合
    if Lib_Util_has brew; then
        Lib_Util_err "brewはインストール済みです"
        return 1
    fi

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" || return 1

    return 0
}

function packages::brew::install_all() {
# Summary: dotfilesディレクトリ直下のpackages.txtで管理されているコマンドをインストールする
    while read -r cmd;
    do
        # コマンドが存在、またはcaskリストに存在する場合
        Lib_Util_has "$cmd" \
        || [[ -n $(brew list --cask | grep "$cmd") ]] \
        && continue

        # インストールが失敗した場合
        brew install "$cmd" \
        || Lib_Util_err "${cmd} はインストールできませんでした。"

    done < <(cat "$PACKAGES")
}

function packages::brew::uninstall_all() {
# Summary: dotfilesディレクトリ直下のpackages.txtで管理されているコマンドをアンインストールする

    while read -r cmd;
    do
        # 対象コマンドが存在しない場合
        if ! Lib_Util_has "$cmd"; then
            if [[ -z $(brew list --cask | grep "$cmd") ]]; then
                 Lib_Util_err "${cmd} はpakages.txtで管理されているが、インストールはされていません" 
                continue
            fi
            continue
        fi

        # アンインストール
        brew uninstall "$cmd"

    done < <(cat "$PACKAGES")
}

function remove() {
# Summary: Homebrewをアンインストールする(x86 amd64)
# 
# Returns:
#   0: アンインストール成功
#   1: brewが存在しない

    # インストールされていない場合
    if ! Lib_Util_has brew; then
        Lib_Util_output "brewコマンドが存在しません。"
        return 1
    fi

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
    return 0
}
