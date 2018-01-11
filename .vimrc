execute pathogen#infect()
call pathogen#helptags()

set backupskip=/tmp/*,/private/tmp/*

set autoindent
"deleteキーで文字を消す
set backspace=indent,eol,start
"バックアップファイルのディレクトリを指定する
set backupdir=$HOME/.vimbackup
""クリップボードをWindowsと連携する
set clipboard+=unnamed
"vi互換をオフする
set nocompatible
""スワップファイル用のディレクトリを指定する
set directory=$HOME/vimbackup
"タブの代わりに空白文字を指定する
"set expandtab
""変更中のファイルでも、保存しないで他のファイルを表示する
set hidden
"インクリメンタルサーチを行う
"set incsearch
""行番号を表示する
set number
"閉括弧が入力された時、対応する括弧を強調する
set showmatch
""新しい行を作った時に高度な自動インデントを行う
set smarttab
" grep検索を設定する
" set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m,%f
" set grepprg=grep\ -nh
" " 検索結果のハイライトをEsc連打でクリアする
" nnoremap <ESC><ESC> :nohlsearch<CR>
"
"  " タブを表示するときの幅
  set tabstop=4
"  " タブを挿入するときの幅
  set shiftwidth=4
"  " タブをタブとして扱う(スペースに展開しない)
"  set noexpandtab
"  "
"  set softtabstop=0
"
"   "----------
"   " カラースキーム
"   "----------
colorscheme molokai
syntax on
"
let s:dein_dir = expand('~/.vim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &compatible
	  set nocompatible
  endif

  if !isdirectory(s:dein_repo_dir)
	    execute '!git clone git@github.com:Shougo/dein.vim.git' s:dein_repo_dir
    endif

    execute 'set runtimepath^=' . s:dein_repo_dir

    call dein#begin(s:dein_dir)
      call dein#add('Shougo/dein.vim')
      call dein#add('Shougo/neocomplete.vim')
      call dein#add('davidhalter/jedi-vim')
      call dein#add('scrooloose/syntastic')
      call dein#add('sophacles/vim-processing')
      call dein#add('plasticboy/vim-markdown')
      call dein#add('kannokanno/previm')
      call dein#add('tyru/open-browser.vim')
      call dein#add('kana/vim-submode')
      call dein#add('Shougo/unite.vim')
      call dein#add('mattn/emmet-vim')
      call dein#add('tpope/vim-surround')
      call dein#add('open-browser.vim')
      call dein#add('othree/html5.vim')
      call dein#add('hail2u/vim-css3-syntax')
      call dein#add('jelera/vim-javascript-syntax')
      call dein#add('ternjs/tern_for_vim')
      call dein#add('davidhalter/jedi-vim')
    call dein#end()

      if dein#check_install()
	        call dein#install()
	endif

	filetype plugin indent on
au BufRead,BufNewFile *.md set filetype=markdown

" autopep
" original http://stackoverflow.com/questions/12374200/using-uncrustify-with-vim/15513829#15513829
function! Preserve(command)
    " Save the last search.
    let search = @/
    " Save the current cursor position.
    let cursor_position = getpos('.')
    " Save the current window position.
    normal! H
    let window_position = getpos('.')
    call setpos('.', cursor_position)
    " Execute the command.
    execute a:command
    " Restore the last search.
    let @/ = search
    " Restore the previous window position.
    call setpos('.', window_position)
    normal! zt
    " Restore the previous cursor position.
    call setpos('.', cursor_position)
endfunction

function! Autopep8()
    "--ignote=E501: 一行の長さの補正を無視"
    call Preserve(':silent %!autopep8 --ignore=E501 -')
endfunction

" Shift + F でautopep自動修正
nnoremap <S-f> :call Autopep8()<CR>

autocmd FileType python setlocal completeopt-=preview
'
"------------------------------------
" neocomplete.vim
"------------------------------------
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete


autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif

" let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

call submode#enter_with('bufmove', 'n', '', 's>', '<C-w>>')
call submode#enter_with('bufmove', 'n', '', 's<', '<C-w><')
call submode#enter_with('bufmove', 'n', '', 's+', '<C-w>+')
call submode#enter_with('bufmove', 'n', '', 's-', '<C-w>-')
call submode#map('bufmove', 'n', '', '>', '<C-w>>')
call submode#map('bufmove', 'n', '', '<', '<C-w><')
call submode#map('bufmove', 'n', '', '+', '<C-w>+')
call submode#map('bufmove', 'n', '', '-', '<C-w>-')
