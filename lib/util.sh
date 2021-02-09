# FileInfo: shell script
#   Desc: 共通で利用する関数の定義ファイル

function Lib_Util_output() {
  # Summary: メッセージを出力する
  #
  # Args:
  #   $1: メッセージ
  echo "$1"
}

function Lib_Util_err() {
  # Summary: エラーメッセージを標準エラ-に出力する
  #
  # Args:
  #   $1 エラーメッセージ
  #
  # echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $1" >&2
  echo "$1" 1>&2
}

function Lib_Util_get_os_type(){
  # Summary: 動作中のOSを出力する
  #
  # Returns:
  #   support: 0
  #   not_support: 1
  case "$(uname -s)" in
    *'Linux'*) echo 'linux'; return 0;;
    *'Darwin'*) echo 'osx'; return 0;;
    *'Bsd'*) echo 'bsd'; return 0;;
    *) echo '$(uname -s) is not supported.'; return 1;;
  esac
}

function Lib_Util_is_x86_64() {
  # Summary: マシンのアーキテクチャがx86/amd64かチェックする
  #
  # Returns:
  #   is_x86/amd64: 0
  #   not_x86/amd64: 1
  [[ $(uname -m) = 'x86_64' ]] && return 0
  return 1
}

function Lib_Util_is_arm64(){
  # Summary: マシンのアーキテクチャがarm64かチェックする
  #
  # Returns:
  #   is_arm64: 0
  #   not_arm64: 1
  [[ $(uname -m) = 'arm64' ]] && return 0
  return 1
}

function Lib_Util_is_osx() {
  # Summary: mac osxかチェックする
  #
  # Returns:
  #   is_osx: 0
  #   not_osx: 1
  [[ $(Lib_Util_get_os_type) = 'osx' ]] && return 0
  return 1
}

function Lib_Util_is_linux() {
  # Summary: linxuかチェックする
  #
  # Returns:
  #   is_linux: 0
  #   not_linux: 1
  [[ $(Lib_Util_get_os_type) = 'linux' ]] && return 0
  return 1
}

function Lib_Util_is_bsd() {
  # Summary: bsdかチェックする
  #
  # Returns:
  #   is_bsd: 0
  #   not_bsd: 1
  [[ $(Lib_Util_get_os_type) = 'bsd' ]] && return 0
  return 1
}

function Lib_Util_is_bash() {
  # Summary: シェルがbashかチェックする
  #
  # Returns:
  #   is_bash: 0
  #   not_bash: 1
  [[ -n "$BASH_VERSION" ]] && return 0
  return 1
}

function Lib_Util_is_zsh() {
  # Summary: shellがzshかチェックする
  #
  # Returns:
  #   is_zsh: 0
  #   not_zsh: 1
  [[ -n "$ZSH_VERSION" ]] && return 0
  return 1
}

function Lib_Util_is_fish(){
  # Summary: shellがfishかチェックする
  #
  # Returns:
  #   is_fish: 0
  #   not_fish: 1
  
  [[ -n "$FISH_VERSION" ]] && return 0
  return 1
}

function Lib_Util_is_empty(){
  # Summary: 文字列の空チェック
  #
  # Args:
  #   $1: 文字列
  #
  # Returns:
  #   is empty: 0
  #   not empty: 1
  [[ -z "$1" ]] && return 0
  [[ "$1" == "" ]] && return 0
  return 1
}

function Lib_Util_get_linux_distribution() {
  # Summary: ディストリビューション名を出力する
  #
  # Returns:
  #   support: 0
  #   not_support: 1
  
  # 実行結果
  local _result=0
  
  if [[ ! -f /etc/*release ]]; then
    echo 'This distribution is not supported'
    _result=1
    
    elif [[ -n $(cat /etc/*release | grep centos) ]]; then
    echo 'centos'
    
    elif [[ -n $(cat /etc/*release | grep ubuntu) ]]; then
    echo 'ubuntu'
    
  else
    echo 'This distribution is not supported'
    _result=1
  fi
  return "$_result"
}

function Lib_Util_has() {
  # Summary: コマンドの存在チェックをする
  #
  # Args:
  #   $1: コマンド
  #
  # Returns:
  #   exists: 0
  #   notExist: 1
  [[ $(which "$1") ]] && return 0
  return 1
}

function Lib_Util_has_path() {
  # Summary: PATHの存在チェックをする
  #
  # Args:
  #   $1: PATH
  #
  # Returns:
  #   exists: 0
  #   notExist 1
  [[ -n $(echo $PATH | grep "$1") ]] && return 0
  return 1
}

function Lib_Util_usage() {
  # Summary: 関数の使用法を出力する
  #
  # Args:
  #   $1: description
  #
  echo "Usage: ${0} ${1}" 1>&2
}
