"カラースキーム設定
colorscheme molokai
syntax on
let g:molokai_original = 1
let g:rehash256 = 1

set background=dark 

set nocompatible               " be iMproved
let s:noplugin = 0
let s:bundle_root = expand('~/.vim/bundle')
let s:neobundle_root = s:bundle_root . '/neobundle.vim.git'

" NeoBundleを'runtimepath'に追加し初期化を行う
if has('vim_starting')
execute "set runtimepath+=" . s:neobundle_root
call neobundle#rc(s:bundle_root)
endif 
