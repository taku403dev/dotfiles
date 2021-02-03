NeoBundle "nathanaelkane/vim-indent-guides"
" let g:indent_guides_enable_on_vim_startup = 1 2013-06-24 10:00 削除
let s:hooks = neobundle#get_hooks("vim-indent-guides")
function! s:hooks.on_source(bundle)
  let g:indent_guides_guide_size = 1
  IndentGuidesEnable " 2013-06-24 10:00 追記
endfunction
