# git cloneした場合の関数
build_pyenv(){
    case $SHELL in
        bash )
            echo 'export PYENV_ROOT="${HOME}/.pyenv"' >> ~/.bash_profile
            echo 'export PATH="${PYENV_ROOT}/bin:$PATH"' >> ~/.bash_profile
            echo 'eval "$(pyenv init -)"' >> ~/.bash_profile
            brew install pyenv
            exec $SHELL -l;;
        zsh )
            echo 'export PYENV_ROOT="${HOME}/.pyenv"' >> ~/.zshenv
            echo 'export PATH="${PYENV_ROOT}/bin:$PATH"' >> ~/.zshenv
            echo 'eval "$(pyenv init -)"' >> ~/.zshenv
            exec $SHELL -l;;
        fish )
    esac
}

remove_pyenv(){
    
}