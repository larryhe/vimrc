" General "{{{
set nocompatible               " be iMproved

set history=256                " Number of things to remember in history.
set timeoutlen=250             " Time to wait after ESC (default causes an annoying delay)
set clipboard+=unnamed         " Yanks go on clipboard instead.
set pastetoggle=<F10>          " toggle between paste and normal: for 'safer' pasting from keyboard
set shiftround                 " round indent to multiple of 'shiftwidth'
set tags=js.tags,tags,.git/tags,$HOME       " consider the repo tags first, then
                               " walk directory tree upto $HOME looking for tags
                               " note `;` sets the stop folder. :h file-search

set path+=*/src/main/webapp/**
set wildignore+=*/target/*,*/build/*,*/bin/*,*.class,*.jar,*.zip,*.jpg,*.png,*.gif,*.tgz,*/yarn-cache/*,*/npm-cache/*
set wildmenu
set modeline
set modelines=5                " default numbers of lines to read for modeline instructions

set autowrite                  " Writes on make/shell commands
set autoread

set nobackup
set nowritebackup
set directory=/tmp//           " prepend(^=) $HOME/.tmp/ to default path; use full path as backup filename(//)
set noswapfile                 "

set hidden                     " The current buffer can be put to the background without writing to disk

set hlsearch                   " highlight search
set ignorecase                 " be case insensitive when searching
set smartcase                  " be case sensitive when input has a capital letter
set incsearch                  " show matches while typing
set relativenumber             " use relative number

let g:is_posix = 1             " vim's default is archaic bourne shell, bring it up to the 90s
let mapleader = ','
let maplocalleader = '	'      " Tab as a local leader
" "}}}

" Formatting "{{{
set fo+=o                      " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set fo-=r                      " Do not automatically insert a comment leader after an enter
set fo-=t                      " Do no auto-wrap text using textwidth (does not apply to comments)

set nowrap
set textwidth=0                " Don't wrap lines by default

set expandtab
set tabstop=4                  " tab size eql 4 spaces
set softtabstop=4
set shiftwidth=4               " default shift width for indents
set expandtab                  " replace tabs with ${tabstop} spaces
set smarttab                   "

set backspace=indent
set backspace+=eol
set backspace+=start

set autoindent
set cindent
set indentkeys-=0#            " do not break indent on #
set cinkeys-=0#
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do
set cinwords+=for,switch,case
" "}}}

" Visual "{{{
syntax on                      " enable syntax

" set synmaxcol=250              " limit syntax highlighting to 128 columns

set mouse=a "enable mouse in GUI mode
set mousehide                 " Hide mouse after chars typed

set number                  " line numbers on
set showmatch                 " Show matching brackets.
set matchtime=2               " Bracket blinking.

set wildmode=longest,list     " At command line, complete longest common string, then list alternatives.

set completeopt+=preview

set novisualbell              " No blinking
set noerrorbells              " No noise.
set vb t_vb=                  " disable any beeps or flashes on error

set laststatus=2              " always show status line.
set shortmess=atI             " shortens messages
set showcmd                   " display an incomplete command in statusline

set statusline=%<%f\          " custom statusline
set stl+=[%{&ff}]             " show fileformat
set stl+=%y%m%r%=
set stl+=%-14.(%l,%c%V%)\ %P


set foldenable                " Turn on folding
set foldmethod=marker         " Fold on the marker
set foldlevel=100             " Don't autofold anything (but I can still fold manually)

set foldopen=block,hor,tag    " what movements open folds
set foldopen+=percent,mark
set foldopen+=quickfix

set virtualedit=block

set splitbelow
set splitright

" set list                      " display unprintable characters f12 - switches
" set listchars=tab:\ ·,eol:¬
" set listchars+=trail:·
" set listchars+=extends:»,precedes:«
map <silent> <F12> :set invlist<CR>

if has('gui_running')
  " set guioptions=cMg " console dialogs, do not show menu and toolbar
  set guifont=Mono\ 12

  " Fonts
  " :set guifont=* " to launch a GUI dialog
  if has('mac')
  set guifont=Andale\ Mono:h13
  else
  set guifont=Mono\ 12
  end

  if has('mac')
  set noantialias
  " set fullscreen
  set fuoptions=maxvert,maxhorz ",background:#00AAaaaa
  endif
endif
" "}}}

" Key mappings " {{{
" Duplication
nnoremap <leader>c mz"dyy"dp`z
vnoremap <leader>c "dymz"dP`z

" nnoremap <C-F> <C-U> " swap ^u
" nnoremap <C-U> <C-F> " with ^f : convenience!
nnoremap <leader>rs :source ~/.vimrc<CR>
nnoremap <leader>rt :tabnew ~/.vim/vimrc<CR>
nnoremap <leader>re :e ~/.vim/vimrc<CR>
nnoremap <leader>rd :e ~/.vim/ <CR>

" Tabs
nnoremap <M-h> :tabprev<CR>
nnoremap <M-l> :tabnext<CR>
nnoremap <leader><Tab> :b#<CR>
" Esc
inoremap ii <Esc>
noremap <localleader><space> <Esc>
inoremap <localleader><space> <Esc>
" noremap <Esc> <NOP>

" Buffers
nnoremap <localleader>- :bd<CR>
nnoremap <localleader>-- :bd!<CR>
nnoremap <leader>be :CtrlPBuffer<CR>
nnoremap <silent>   <tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bnext<CR>
nnoremap <silent> <s-tab>  :if &modifiable && !&readonly && &modified <CR> :write<CR> :endif<CR>:bprevious<CR>
" Split line(opposite to S-J joining line)
nnoremap <C-J> gEa<CR><ESC>ew

" map <silent> <C-W>v :vnew<CR>
" map <silent> <C-W>s :snew<CR>

" copy filename 
map <silent> <leader>f :let @+=expand('%')<CR>
map tsilent> <leader>. :let @+=expand('%:p').':'.line('.')<CR>
map <silent> <leader>/ :let @+=expand('%:p:h')<CR>
" copy path
nmap <leader>yw :let @+=expand('<cword>')<CR>
map <S-CR> A<CR><ESC>

map <leader>E :Explore<CR>
map <leader>EE :Vexplore!<CR><C-W>=

" copy to clipboard
vmap <C-x> :!pbcopy<CR>  
vmap <C-c> :w !pbcopy<CR><CR>
" Make Control-direction switch between windows (like C-W h, etc)
nmap <silent> <C-k> <C-W><C-k>
nmap <silent> <C-j> <C-W><C-j>
nmap <silent> <C-h> <C-W><C-h>
nmap <silent> <C-l> <C-W><C-l>

  " vertical paragraph-movement
nmap <C-J> {
nmap <C-K> }

" vertical split with CommandT
nnoremap <leader>v :exec ':vnew \| CommandT'<CR>
" and without
nnoremap <leader>V :vnew<CR>

if has('mac')

  if has('gui_running')
    set macmeta
  end

" map(range(1,9), 'exec "imap <D-".v:val."> <C-o>".v:val."gt"')
" map(range(1,9), 'exec " map <D-".v:val."> ".v:val."gt"')

" Copy whole line
nnoremap <silent> <D-c> yy

" close/delete buffer when closing window
map <silent> <D-w> :bdelete<CR>
endif

" Control+S and Control+Q are flow-control characters: disable them in your terminal settings.
" $ stty -ixon -ixoff
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>
"
" generate HTML version current buffer using current color scheme
map <leader>2h :runtime! syntax/2html.vim<CR>

ab #e # encoding: UTF-8
" " }}}

" AutoCommands " {{{
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru}     set ft=ruby tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
au BufRead,BufNewFile {*.md,*.mkd,*.markdown}                         setf markdown
au BufRead,BufNewFile {*.scala}                                       setf scala
au! BufReadPost       {COMMIT_EDITMSG,*/COMMIT_EDITMSG}               set ft=gitcommit noml list| norm 1G
au! BufWritePost      *.snippet                                       call ReloadAllSnippets()
" open help in vertical split
au BufWinEnter *.txt if &ft == 'help' | wincmd H | endif
" " }}}

" Scripts and Bundles " {{{
filetype off
runtime macros/matchit.vim
set rtp+=~/.vim/bundle/vundle/
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
call plug#begin('~/.vim/bundle')

" Colorscheme
Plug 'tomasr/molokai'
Plug 'msanders/snipmate.vim'

" Git integration
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'

nnoremap <leader>W :Gwrite<CR>
nnoremap <leader>C :Gcommit -v<CR>
nnoremap <leader>S :Gstatus \| 7<CR>
inoremap <leader>W <Esc><leader>W
inoremap <leader>C <Esc><leader>C
inoremap <leader>S <Esc><leader>S

Plug 'tpope/vim-unimpaired'
" bubble current line
nmap <M-j> ]e
nmap <M-k> [e
" bubble visual selection lines
vmap <M-j> ]egv
vmap <M-k> [egv

Plug 'michaeljsmith/vim-indent-object'
Plug 'AndrewRadev/splitjoin.vim'
nmap sj :SplitjoinJoin<cr>
nmap sk :SplitjoinSplit<cr>

Plug 'kana/vim-textobj-user'
Plug 'gmarik/ide-popup.vim'


Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

Plug 'Lokaltog/vim-easymotion'
let g:EasyMotion_leader_key='<LocalLeader>'

Plug 'nathanaelkane/vim-indent-guides'
let g:indent_guides_guide_size = 1


Plug 'tomtom/tlib_vim'
Plug 'tomtom/tcomment_vim'
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<leader>t'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_max_height = 30
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height = 20
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_switch_buffer = 'e'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|yarn-cache\|npm-cache'
nnoremap <leader>bl :CtrlPBuffer <cr>

Plug 'Townk/vim-autoclose'
Plug 'vim-scripts/sessionman.vim'
Plug 'majutsushi/tagbar'
Plug 'vim-scripts/taglist.vim'
Plug 'clausreinke/scoped_tags'
Plug 'mileszs/ack.vim'
Plug 'Chiel92/vim-autoformat'
Plug 'ternjs/tern_for_vim'
Plug 'scrooloose/nerdtree'
nnoremap <leader>af :Autoformat <cr><cr>
nnoremap <leader>cq :cclose <sr>
nnoremap <space>n :NERDTreeToggle <cr>
" handy key binding starts with <space>
noremap <space>q <Esc>:wqa<CR>
inoremap <space>q <Esc>:wqa<CR>
map <space>g <Esc>:lcd %:p:h<CR>
vmap <C-x> :!pbcopy<CR>  
vmap <C-c> :w !pbcopy<CR><CR>
" Plug 'kchmck/vim-coffee-script'
Plug 'jimenezrick/vimerl'
" Plug 'scrooloose/syntastic'
Plug 'Shougo/unite.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'w0rp/ale'
let g:ale_linters={'javascript': ['eslint']}
let g:ale_fixers={'javascript': ['eslint']}
let g:ale_fix_on_save=1
" let g:ale_javascript_prettier_use_local_config=1
" let g:syntastic_javascript_checkers=['jshint']
call plug#end()
" set color scheme and use 256 color
set t_Co=256
let g:molokai_original=1
colorscheme molokai
set cursorline  "highlight the line cursor is on
highlight CursorLine guibg=darkgray ctermbg=darkgray
