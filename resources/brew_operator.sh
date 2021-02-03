# Homebrewパッケージマネージャーを操作する関数

source ${DOTPATH}/lib/util.sh

# インストール済みCUIパッケージを一括削除
uninstall_homebrew_formula_all() {

    tmp=/tmp/$(date  "+%Y%m%d%H%M%s").tmp
    brew list --formula >> $tmp

    while read -f cmd;
        do
            has $cmd \
            && brew uninstall $cmd \
            || echo "$(date  "+%Y-%m-%dT%H:%M:%S") Faild $cmd uninstall" >> /tmp/clean_err.log
        done < < (cat $tmp)

    rm $tmp
}

# インストール済みGUIパッケージを一括削除
uninstall_homebrew_cask_all() {

    tmp=/tmp/$(date  "+%Y%m%d%H%M%s").tmp
    brew list --cask > $tmp

    while read -f cmd;
        do
            has $cmd \
            && brew uninstall $cmd \
            || echo "$(date  "+%Y-%m-%dT%H:%M:%S") Faild $cmd uninstall" >> /tmp/clean_err.log
        done < < (cat $tmp)

    rm $tmp
}

# インストール済みのパッケージを一括削除
uninstall_homebrew_all(){
    uninstall_homebrew_formula_all
    uninstall_homebrew_cask_all
}

# Homebrewをインストールする(M1 Mac)
install_homebrew_arm64() {
    has brew && uninstall_homebrew_all; return
    xcode-select --install
    CRENT_PWD=$(pwd)
    cd /opt
    sudo mkdir homebrew
    sudo chown $USER /opt/homebrew
    curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C homebrew
    echo 'export PATH=/opt/homebrew/bin:$PATH' >> .zshrc
    brew update
    cd "$CRENT_PWD"
}

# Homebrewをインストールする(x86 amd64)
install_homebrew_x86_64() {
    has brew && uninstall_homebrew_all; return
    xcode-select --install
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# Homebrewをアンインストールする(x86 amd64)
uninstall_homebrew_x86_64() {
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
}
