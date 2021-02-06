#!/bin/bash
# OSごとに異なるデプロイを実行

. "${DOTPATH}/lib/util.sh"
. "${DOTPATH}/os/osx.sh"

# macの場合
if Lib_Util_is_osx; then
    echo "Build the environment for osx."
    os::osx:deploy || exit 1
    echo "Succeeded in building osx environment."
fi
