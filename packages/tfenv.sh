# terraformのインストールと設定

# tfenvが未インストールの場合
tfenv='.tfenv';
if [[ ! -d "${HOME}/${tfenv}" ]]; then
    git clone https://github.com/tfutils/tfenv.git "${HOME}/${tfenv}"
fi

# パス設定
export PATH="${HOME}/${tfenv}/bin:${PATH}"
