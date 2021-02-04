# Homebrewパッケージマネージャーを操作する関数

. ${DOTPATH}/lib/util.sh

packages::brew::setup_arm64() {
# Homebrewをインストールする(M1 Mac)

    # 既にインストール済みかチェック
    if lib::util::has brew; then
        echo "Homebrew is already installed."
        exit 1
    fi

    cnt_dir=$(pwd)
    # パスの存在チェック 
    if [[ ! -f /opt/homebrew/bin/brew ]]; then
        cd /opt
        sudo mkdir homebrew
        sudo chown $USER /opt/homebrew
        curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
    fi

    # パスが通っているかチェック
    if [[ $(grep 'export PATH=/opt/homebrew/bin:$PATH' '.zshrc') != 'export PATH=/opt/homebrew/bin:$PATH' ]]; then
        echo 'export PATH=/opt/homebrew/bin:$PATH' >> "${HOME}/.zshrc"
        source "${HOME}/.zshrc"
    fi
    
    brew update
    cd "$cnt_dir"
}

packages::brew::setup_x86_64() {
# Homebrewをインストールする(x86 amd64)

    # 既にインストール済みかチェック
    if lib::util::has brew; then
        echo "Homebrew is already installed."
        exit 1
    fi

    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# Homebrewをアンインストールする(x86 amd64)
remove() {
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
}
