# mac osxの開発環境構築を管理するファイル

source "${DOTPATH}/resources/brew_operator.sh"
source "${DOTPATH}/lib/util.sh"

function os::osx::setup_manager::prepare() {
    # パッケージマネージャー導入のための準備処理
    # マシンタイプごとにインストール方法を変更
    if lib::util::is_x86_64; then
        install_homebrew_x86_64

    elif is_arm64; then
        install_homebrew_arm64
}

function os::osx::setup_manager::install() {
    # パッケージマネージャーがインストール作業を実行
    # dotfilesディレクトリ直下のpackages.csvに記載されているコマンドをインストール
    while read -f cmd;
    do
        has "$cmd" || brew install "$cmd"
    done < < (cat "${DOTPATH}/packages.csv")
}

function os::osx::setup_manager::deploy() {
    # macの開発環境を構築する
    # パッケージマネージャーを利用する準備
    os::osx::setup_manager::prepare
    # パッケージのインストール作業
    os::osx::setup_manager::install
    # ビルド作業
    source "${DOTPATH]/bin/build.sh"
}
