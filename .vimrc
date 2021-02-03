"Osで切り分け
if has("unix")
  set guifont=Rictty 10
elseif has("win32") || has("win64")
	set iminsert=0
	set imsearch=1
endif
"
"カラースキーマを設定
colorscheme molokai
syntax on
let g:molokai_original = 1
let g:rehash256 = 1
"set background=dark

" release autogroup in MyAutoCmd
augroup MyAutoCmd
autocmd!
augroup END

"----------------------------検索関係----------------------------------------
set ignorecase          " 大文字小文字を区別しない
set smartcase           " 検索文字に大文字がある場合は大文字小文字を区別
set incsearch           " インクリメンタルサーチ
set hlsearch            " 検索マッチテキストをハイライト (2013-07-03 14:30 修正）

" バックスラッシュやクエスチョンを状況に合わせ自動的にエスケープ
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

"----------------------編集関係---------------------------------------------

set shiftround          " '<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase           " 補完時に大文字小文字を区別しない
set virtualedit=all     " カーソルを文字が存在しない部分でも動けるようにする
set hidden              " バッファを閉じる代わりに隠す（Undo履歴を残すため）
set switchbuf=useopen   " 新しく開く代わりにすでに開いてあるバッファを開く
set showmatch           " 対応する括弧などをハイライト表示する
set matchtime=3         " 対応括弧のハイライト表示を3秒にする

" 対応括弧に'<'と'>'のペアを追加
set matchpairs& matchpairs+=<:>

" バックスペースでなんでも消せるようにする
set backspace=indent,eol,start

" クリップボードをデフォルトのレジスタとして指定。後にYankRingを使うので
" 'unnamedplus'が存在しているかどうかで設定を分ける必要がある
if has('unnamedplus')
" set clipboard& clipboard+=unnamedplus " 2013-07-03 14:30 unnamed 追加
 set clipboard& clipboard+=unnamedplus,unnamed 
else
" set clipboard& clipboard+=unnamed,autoselect 2013-06-24 10:00 autoselect 削除
set clipboard& clipboard+=unnamed
endif

" Swapファイル？Backupファイル？前時代的すぎ
" なので全て無効化する
set nowritebackup
set nobackup
set noswapfile

set list                " 不可視文字の可視化
set number              " 行番号の表示
set wrap                " 長いテキストの折り返し
set textwidth=0         " 自動的に改行が入るのを無効化
set colorcolumn=80      " その代わり80文字目にラインを入れる

" 前時代的スクリーンベルを無効化
set t_vb=
set novisualbell

" デフォルト不可視文字は美しくないのでUnicodeで綺麗に
set encoding=utf-8

" 入力モード中に素早くjjと入力した場合はESCとみなす
inoremap jj <Esc>

" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>

" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk

" vを二回で行末まで選択
vnoremap v $h

" TABにて対応ペアにジャンプ
nnoremap <Tab> %
vnoremap <Tab> %

" Ctrl + hjkl でウィンドウ間を移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Shift + 矢印でウィンドウサイズを変更
nnoremap <S-Left>  <C-w><<CR>
nnoremap <S-Right> <C-w>><CR>
nnoremap <S-Up>    <C-w>-<CR>
nnoremap <S-Down>  <C-w>+<CR>

" T + ? で各種設定をトグル
nnoremap [toggle] <Nop>
nmap T [toggle]
nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>

" make, grep などのコマンド後に自動的にQuickFixを開く
autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep copen

" QuickFixおよびHelpでは q でバッファを閉じる
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
if !isdirectory(a:dir) && (a:force ||
                                   \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
endif
endfunction
autocmd MyAutoCmd BufWritePre * call s:mkdir(expand('<afile>:p:h'), v:cmdbang)

" vim 起動時のみカレントディレクトリを開いたファイルの親ディレクトリに指定
autocmd MyAutoCmd VimEnter * call s:ChangeCurrentDir('', '')
function! s:ChangeCurrentDir(directory, bang)
if a:directory == ''
lcd %:p:h
else
execute 'lcd' . a:directory
endif

if a:bang == ''
pwd
endif
endfunction

" ~/.vimrc.localが存在する場合のみ設定を読み込む
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
execute 'source ' . s:local_vimrc
endif

"--------------------------------------------------------------------------
set nocompatible               " be iMproved

let s:noplugin = 0
if has('unix')
let s:bundle_root = expand('~/.vim/bundle')
let s:neobundle_root = s:bundle_root . '/neobundle.vim.git'
endif

if has('win32') || has('win64')
let s:bundle_root = expand('~/vimfiles/bundle')
let s:neobundle_root = s:bundle_root . '/neobundle.vim.git'
endif

if !isdirectory(s:neobundle_root) || v:version < 702
" NeoBundleが存在しない、もしくはVimのバージョンが古い場合はプラグインを一切
" 読み込まない
let s:noplugin = 1
else
" NeoBundleを'runtimepath'に追加し初期化を行う
if has('vim_starting')
execute "set runtimepath+=" . s:neobundle_root
call neobundle#rc(s:bundle_root)
endif

" NeoBundle自身をNeoBundleで管理させる
NeoBundleFetch 'Shougo/neobundle.vim'

" 非同期通信を可能にする
" 'build'が指定されているのでインストール時に自動的に
" 指定されたコマンドが実行され vimproc がコンパイルされる
NeoBundle "Shougo/vimproc", {
\ "build": {
\   "windows"   : "make -f make_mingw32.mak",
\   "cygwin"    : "make -f make_cygwin.mak",
\   "mac"       : "make -f make_mac.mak",
\   "unix"      : "make -f make_unix.mak",
\ }}

" (ry

" インストールされていないプラグインのチェックおよびダウンロード
if has("win64")
NeoBundleCheck
endif

" ファイルタイププラグインおよびインデントを有効化
" これはNeoBundleによる処理が終了したあとに呼ばなければならない
filetype plugin indent on

" 次に説明するがInsertモードに入るまではneocompleteはロードされない
NeoBundleLazy 'Shougo/neocomplete.vim', {
\ "autoload": {"insert": 1}}
" neocompleteのhooksを取得
let s:hooks = neobundle#get_hooks("neocomplete.vim")
" neocomplete用の設定関数を定義。下記関数はneocompleteロード時に実行される
function! s:hooks.on_source(bundle)
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#keyword_patterns['gosh-repl'] = "[[:alpha:]+*/@$_=.!?-][[:alnum:]+*/@$_:=.!?-]*"
" NeoCompleteを有効化
NeoCompleteEnable
endfunction

" Insertモードに入るまでロードしない

NeoBundleLazy 'Shougo/neosnippet.vim', {
\ "autoload": {"insert": 1}}
" 'GundoToggle'が呼ばれるまでロードしない
NeoBundleLazy 'sjl/gundo.vim', {
\ "autoload": {"commands": ["GundoToggle"]}}
" '<Plug>TaskList'というマッピングが呼ばれるまでロードしない
NeoBundleLazy 'vim-scripts/TaskList.vim', {
\ "autoload": {"mappings": ['<Plug>TaskList']}}
" HTMLが開かれるまでロードしない
NeoBundleLazy 'mattn/zencoding-vim', {
\ "autoload": {"filetypes": ['html']}}

NeoBundle "thinca/vim-template"
if has('unix')
NeoBundle 'yuratomo/w3m.vim' 
endif
NeoBundle 'daisuzu/translategoogle.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'vim-scripts/Zenburn'
NeoBundle 'PProvost/vim-ps1'
NeoBundle 'aharisu/vim_goshrepl'
NeoBundle 'aharisu/vim-gdev'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'KazuyaHayashi/bing-translate.vim'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'taichouchou2/html5.vim'
NeoBundle 'altercation/solarized'
NeoBundle 'mattn/excelview-vim'
NeoBundle 'hachibeeDI/vim-vbnet' j
endif

filetype plugin indent on
" テンプレート中に含まれる特定文字列を置き換える
autocmd MyAutoCmd User plugin-template-loaded call s:template_keywords()
function! s:template_keywords()
silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
silent! %s/<+FILENAME+>/\=expand('%:r')/g
endfunction
" テンプレート中に含まれる'<+CURSOR+>'にカーソルを移動
autocmd MyAutoCmd User plugin-template-loaded
\   if search('<+CURSOR+>')
\ |   silent! execute 'normal! "_da>'
\ | endif

"""""""""""""
" Anywhere SID.
function! s:SID_PREFIX()
return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
let s = ''
for i in range(1, tabpagenr('$'))
let bufnrs = tabpagebuflist(i)
let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
let no = i  " display 0-origin tabpagenr.
let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
let title = fnamemodify(bufname(bufnr), ':t')
let title = '[' . title . ']'
let s .= '%'.i.'T'
let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
let s .= no . ':' . title
let s .= mod
let s .= '%#TabLineFill# '
endfor
let s .= '%#TabLineFill#%T%=%#TabLine#'
return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ

"Gauche Plugin Setting
fun! GoshRunAll()

w%
let fname = expand("%")

execute ":Scratch"

execute ":0,%delete"

if has('mac')
execute "r !/opt/local/bin/gosh -i <".fname
elseif has('unix')
execute "r !/usr/bin/gosh -i <".fname
elseif has('win32') || ('win64') 
execute "r !D:\Program Files (x86)\Gauche\bin\gosh.exe <".fname
endif

endfun

nmap ,s :call GoshRunAll()<cr>


"vim html configre
let g:user_emmet_leader_key='<c-t>'
"タグ自動補完
augroup MyXML
autocmd!
autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
autocmd Filetype eruby inoremap <buffer> </ </<C-x><C-o>
augroup end

"自動で括弧を補完
inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>

inoremap [ []<Left>
inoremap [<Enter> []<Left><CR><ESC><S-o>

inoremap " ""<Left>
inoremap "<Enter> ""<Left><CR><ESC><S-o>

inoremap ' ''<Left>
inoremap '<Enter> ''<Left><CR><ESC><S-o>

inoremap ` ``<Left>
inoremap `<Enter> ``<Left><CR><ESC><S-o>
