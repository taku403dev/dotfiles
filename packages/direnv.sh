# FileInfo: direnvの管理

. "${DOTPATH}/lib/util.sh"

function pakcages::direnv::setup() {
  # Summary: direnvの設定をする
  if Lib_Util_has 'direnv'; then
    export EDITOR=$(which vi)
    eval "$(direnv hook zsh)"
    direnv allow
  fi
}
