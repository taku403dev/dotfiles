#!/bin/bash
# OSごとに異なるデプロイを実行

source "${DOTPATH}/lib/util.sh"
source "${DOTPATH}/setup/osx/setup_manager.sh"

if is_osx; then
    os::osx::setup_manager::deploy
fi
