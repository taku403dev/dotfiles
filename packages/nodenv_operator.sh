setup_nodenv() {
    echo 'setup nodenv'
    git clone git://github.com/nodenv/nodenv.git $PATH_NODENV && \
    git clone https://github.com/nodenv/node-build.git ~/.nodenv/plugins/node-build && \
    git clone https://github.com/nodenv/node-build-update-defs.git ~/.nodenv/plugins/node-build-update-defs && \
    curl -fsSL https://github.com/nodenv/nodenv-installer/raw/master/bin/nodenv-doctor | bash
}
