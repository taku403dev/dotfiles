 " vim-ref {{{
NeoBundle 'thinca/vim-ref'
let g:ref_cache_dir=$HOME.'/.vim/vim-ref/cache'
let g:ref_phpmanual_path=$HOME.'/.vim/vim-ref/php-chunked-xhtml'
"}}} 
"
" vim-tags {{{
NeoBundle 'szw/vim-tags'
autocmd MyAutoCmd BufNewFile,BufRead $HOME/sample/*.php setlocal tags=$HOME/.vim/tags/sample.tags
autocmd MyAutoCmd BufNewFile,BufRead $HOME/test/*.php   setlocal tags=$HOME/.vim/tags/test.tags
"}}}
" taglist.vim {{{
NeoBundleLazy 'vim-scripts/taglist.vim', {
\    'autoload' : {
\        'commands' : 'Tlist',},}
let Tlist_Use_Right_Window = 1
let Tlist_Show_One_File = 1
let Tlist_Exit_OnlyWindow = 1
let g:tlist_php_settings = 'php;c:class;f:function;d:constant'
nnoremap <Leader>t :Tlist<CR>
"}}} 
"syntaxチェック設定

"構文チェックを非同期で定期的に行われるため効率よく開発が進められます。


" vimproc {{{
NeoBundle 'Shougo/vimproc', {
\    'build' : {
\        'mac'  : 'make -f make_mac.mak',
\        'unix' : 'make -f make_unix.mak',},}
"}}}
" vim-quickrun {{{
NeoBundle 'thinca/vim-quickrun'
nnoremap <Leader>r :QuickRun<CR>
let g:quickrun_config = {
\    '_' : {
\        'hook/close_buffer/enable_failure':    1,
\        'hook/close_buffer/enable_empty_data': 1,
\        'runner':                              'vimproc',
\        'runner/vimproc/updatetime':           60,
\        'outputter':                           'multi:buffer:quickfix',
\        'outputter/buffer/split':              ':botright',
\        'outputter/buffer/close_on_empty':     1,},
\    'watchdogs_checker/_' : {
\        'hook/close_quickfix/enable_exit':           1,
\        'hook/back_window/enable_exit':              0,
\        'hook/back_window/priority_exit':            1,
\        'hook/quickfix_status_enable/enable_exit':   1,
\        'hook/quickfix_status_enable/priority_exit': 2,
\        'hook/qfsigns_update/enable_exit':           1,
\        'hook/qfsigns_update/priority_exit':         3,
\        'hook/qfstatusline_update/enable_exit':      1,
\        'hook/qfstatusline_update/priority_exit':    4,},
\    'watchdogs_checker/php' : {
\        'command':     'php',
\        'exec':        '%c -d error_reporting=E_ALL -d display_errors=1 -d display_startup_errors=1 -d log_errors=0 -d xdebug.cli_color=0 -l %o %s:p',
\        'errorformat': '%m\ in\ %f\ on\ line\ %l',},}
"}}}
" vim-watchdogs {{{
NeoBundleLazy 'osyo-manga/vim-watchdogs', {
\    'depends': ['thinca/vim-quickrun', 'osyo-manga/shabadou.vim', 'KazuakiM/vim-qfsigns', 'KazuakiM/vim-qfstatusline', 'dannyob/quickfixstatus'],
\    'autoload' : {
\        'filetypes': ['php'],},}
let s:hooks = neobundle#get_hooks('vim-watchdogs')
function! s:hooks.on_source(bundle)
    "vim-qfsigns
    nnoremap <Leader>sy :QfsignsJunmp<CR>
    "vim-qfstatusline (This setting is userd at lightline)
    "let g:Qfstatusline#UpdateCmd = function('lightline#update')
    "vim-watchdogs
    let g:watchdogs_check_BufWritePost_enable = 0
    let g:watchdogs_check_BufWritePost_enables = {
    \   'php' : 1,}
    let g:watchdogs_check_CursorHold_enable = 1
endfunction
unlet s:hooks
 
