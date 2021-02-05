# Homebrewパッケージマネージャーを操作する関数

# ライブラリ
. ${DOTPATH}/lib/util.sh

# インストールするパッケージが格納する変数
# declare packages_csv="${DOTPATH}/packages.csv"
declare packages_csv="${DOTPATH}/packages_cask.csv"

function packages::brew::setup_arm64() {
# Homebrewをインストールする(M1 Mac)

    # 移動するので現在パスの位置を記憶
    declare cnt_dir=$(pwd)

    # インストール済みの場合
    lib::util::has brew && return 0

    # 実行ファイルが存在しない場合
    if [[ ! -f /opt/homebrew/bin/brew ]]; then
        cd /opt
        sudo mkdir homebrew
        sudo chown $USER /opt/homebrew
        curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
        cd "$cnt_dir"
    fi

    # 環境変数にパスが通っていない場合
    if ! grep 'export PATH=/opt/homebrew/bin:$PATH' "${DOTPATH}/.zshrc" >/dev/null 2>&1; then
        echo 'export PATH=/opt/homebrew/bin:$PATH' >> "${HOME}/.zshrc"
        source "${HOME}/.zshrc"
    fi
    
    # 更新
    brew update
    return 0
}

function packages::brew::setup_x86_64() {
# Homebrewをインストールする(x86 amd64)

    # インストール済みの場合
    lib::util::has brew && return 0

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    return 0
}

function packages::brew::install_all() {
# dotfilesディレクトリ直下のpackages.csvで管理されているコマンドをインストールする
    while read -r cmd;
    do
        # インストール済みの場合
        lib::util::has "$cmd" && continue

        brew install "$cmd" \
        || lib::util::err "${cmd} could not be installed."

    done < <(cat $packages_csv)

    return 0
}

function packages::brew::uninstall_all() {
# dotfilesディレクトリ直下のpackages.csvで管理されているコマンドをアンインストールする

    while read -r cmd;
    do
        # パッケージが存在しない場合
        ! lib::util::has "$cmd" && [[ $(brew list --cask) != "$cmd" ]] && continue

        # アンインストールに失敗した場合
        if ! $(brew uninstall "$cmd" >/dev/null 2>&1); then
            lib::util::err "${cmd} could not be installed."
        fi

    done < <(cat "$packages_csv")

    return 0
}

function remove() {
# Homebrewをアンインストールする(x86 amd64)

    # 未インストールの場合
    ! lib::util::has brew && return 0

    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
    return 0
}
