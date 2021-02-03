" 次に説明するがInsertモードに入るまではneocompleteはロードされない
NeoBundleLazy 'Shougo/neocomplete.vim', {
    \ "autoload": {"insert": 1}}
" neocompleteのhooksを取得
let s:hooks = neobundle#get_hooks("neocomplete.vim")
" neocomplete用の設定関数を定義。下記関数はneocompleteロード時に実行される
function! s:hooks.on_source(bundle)
    let g:acp_enableAtStartup = 0
    let g:neocomplete#enable_smart_case = 1
    " NeoCompleteを有効化
    NeoCompleteEnable
endfunction
