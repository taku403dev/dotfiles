# mac osxの開発環境構築を管理するファイル

. "${DOTPATH}/packages/brew.sh"
. "${DOTPATH}/lib/util.sh"


function os::osx::prepare() {
    # パッケージマネージャー導入準備
    xcode-select --install
    # マシンタイプごとにインストール方法を指定
    if lib::util::is_x86_64; then
        packages::brew::setup_x86_64

    elif lib::util::is_arm64; then
        packages::brew::setup_arm64
    fi
}

function os::osx::install() {
    # dotfilesディレクトリ直下のpackages.csvに記載されているコマンドをインストール
    while read cmd;
    do
        # パッケージがインストール済みの場合
        if lib::util::has "$cmd"; then
            continue
        fi

        brew install "$cmd"
        # インストール失敗の場合
        if [[ $? -ne 0 ]]; then
            lib::util::err "${cmd} failed to install."
        fi

    done < <(cat "${DOTPATH}/packages.csv")
}

function os::osx:deploy() {
    # macの開発環境を構築する
    # パッケージマネージャーを利用する準備
    os::osx::prepare
    # パッケージのインストール作業
    os::osx::install
}
