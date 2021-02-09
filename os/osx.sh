# FileInfo: mac osxの開発環境構築を管理する

. "${DOTPATH}/packages/brew.sh"
. "${DOTPATH}/lib/util.sh"


function os::osx::prepare() {
  # Summary: パッケージマネージャー導入準備
  #
  xcode-select --install
  
  # マシンタイプごとにインストール方法を指定
  if Lib_Util_is_x86_64; then
    packages::brew::setup_x86_64
    
    elif Lib_Util_is_arm64; then
    packages::brew::setup_arm64
  fi
}

function os::osx::install() {
  # Sumary: dotfilesディレクトリ直下のpackages.txtで管理されているコマンドをインストール
  #
  # Returns:
  #   success: 0
  #   Failure: 1
  pakcages_csv::brew::install_all || return 1
  # インストール処理に失敗した場合
  
  return 0
}

function os::osx:deploy() {
  # Summary: macの開発環境を構築する
  #
  # パッケージマネージャーを利用する準備
  os::osx::prepare
  # パッケージのインストール作業
  os::osx::install
}
