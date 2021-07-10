#################Git操作#######################

# git_repositories.csvに記載してある全コマンド名を取得
get_git_command_names_list() {
  cat ${DOTPATH}/git_repositories.csv | awk -F, '{print $1}' | tr -s '\n'
}

# git_repositories.csvに記載してある全urlを取得
get_all_git_url() {
  cat ${DOTPATH}/git_repositories.csv | awk -F, '{print $2}' | tr -s '\n'
}

#  git_repositories.csvから対象のコマンド情報を取得
get_git_command_info() {
  grep $1 "${DOTPATH}/git_repositories.csv"
}
