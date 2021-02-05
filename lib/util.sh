
function lib::util::get_os_type(){
    # 現在動作中のOSを取得する
    case "$(uname -s)" in
        *'Linux'*) echo 'linux';;
        *'Darwin'*) echo 'osx';;
        *'Bsd'*) echo 'bsd';;
        *) echo 'This OS is not supported.';;
    esac
    return 0
}

function lib::util::is_x86_64() {
    [[ $(uname -m) = 'x86_64' ]] && return 0
    return 1
}

function lib::util::is_arm64(){
    [[ $(uname -m) = 'arm64' ]] && return 0
    return 1
}

function lib::util::is_osx() {
# mac osxか確認
    if [[ $(lib::util::get_os_type) = 'osx' ]]; then
        return 0
    fi
    return 1
}

function lib::util::is_linux() {
    # linuxか確認
    if [[ $(lib::util::get_os_type) = 'linux' ]]; then
        return 0
    fi
    return 1
}

function lib::util::is_bsd() {
    # bsdか確認
    if [[ $(lib::util::get_os_type) = 'bsd' ]]; then
        return 0
    fi
    return 1
}

function lib::util::is_bash() {
    # シェルがbashか確認

    [ -n "$BASH_VERSION" ]
}

function lib::util::is_zsh() {
    # shellがzshか確認

    [ -n "$ZSH_VERSION" ]
}

function lib::util::is_fish(){
    # shellがfishか確認

    [ -n $FISH_VERSION ]
}

function lib::util::is_empty(){
    # 文字列の空チェック

    [ -z "$1" ] && return 0
    [ "$1" == "" ] && return 0
    return 1
}

function lib::util::lower(){
    if [ $# -eq 0 ]; then
        cat <&0
    elif [ $# -eq 1 ]; then
        if [ -f "$1" -a -r "$1" ]; then
            cat "$1"
        fi
    else return 1
    fi | tr "[:upper]" "[:lower]"
}

function lib::util::get_linux_distribution() {
    # ディストリビューション名を取得

    if [[ $(cat /etc/*release | grep centos) ]]; then
        echo 'centos';
    elif [[ $(cat /etc/*release | grep ubuntu) ]]; then
        echo 'ubuntu';
    else
        return 1
    fi
}

function lib::util::die() {
    # 文字列を出力し終了する
    echo "$1"
    exit 0;
}


function lib::util::err() {
# エラーメッセージを標準エラ-に出力する
# Arguments:
#   $1 エラーメッセージ
# Returns:
#   0
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $1" >&2
    return 0
}

function lib::util::has() {
    # コマンドの存在チェック

    which $1 >/dev/null 2>&1 && return 0
    return 1
}

function lib::util::usage() {
# 関数の使用法
# Args:
#   $1: description
    echo "Usage: ${0} ${1}" 1>&2
}