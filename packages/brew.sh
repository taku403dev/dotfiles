# Homebrewパッケージマネージャーを操作する関数

# ライブラリ
. ${DOTPATH}/lib/util.sh


function packages::brew::setup_arm64() {
# Summary: Homebrewをインストールする(M1 Mac)

    # 移動するので現在パスの位置を記憶
    local declare current_dir=$(pwd)

    # インストール済みの場合
    Lib_Util_has brew && return 0

    # 実行ファイルが存在しない場合
    if [[ ! -f /opt/homebrew/bin/brew ]]; then
        cd /opt
        sudo mkdir homebrew
        sudo chown $USER /opt/homebrew
        curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
        cd "$current_dir"
    fi

    # 環境変数にパスが通っていない場合
    if Lib_Util_has brew; then
        echo 'export PATH=/opt/homebrew/bin:$PATH' >> "${HOME}/.zshrc"
        source "${HOME}/.zshrc"
    fi
    
    # 更新
    brew update
}

function packages::brew::setup_x86_64() {
# Summary: Homebrewをインストールする(x86 amd64)

    # インストール済みの場合
    Lib_Util_has brew && return 0

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

function packages::brew::install_all() {
# Summary: dotfilesディレクトリ直下のpackages.txtで管理されているコマンドをインストールする
    while read -r cmd;
    do
        # インストール済みの場合
        Lib_Util_has "$cmd" \
        && brew list --cask | grep "$cmd" && continue

        brew install "$cmd" \
        || Lib_Util_err "${cmd} could not be installed."

    done < <(cat "$PACKAGES")
}

function packages::brew::uninstall_all() {
# Summary: dotfilesディレクトリ直下のpackages.txtで管理されているコマンドをアンインストールする

    while read -r cmd;
    do
        # パッケージが存在しない場合
        Lib_Util_has "$cmd" \
        || Lib_Util_is_empty $(brew list --cask | grep "$cmd") \
        &&continue

        # アンインストールに失敗した場合
        brew uninstall "$cmd" \
        || Lib_Util_err "${cmd} could not be installed."

    done < <(cat "$PACKAGES")
}

function remove() {
# Summary: Homebrewをアンインストールする(x86 amd64)

    # 未インストールの場合
    Lib_Util_has brew || return 0

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
}
