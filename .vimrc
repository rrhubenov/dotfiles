"--------BASIC CONFIG BEGIN-------------

filetype plugin indent on
syntax on

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=1000	" keep 200 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line
set wildmode=list:longest,full
set hlsearch
set incsearch
set laststatus=2
colorscheme desert

set tabstop=4
set shiftwidth=4
set expandtab


set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key

" Show @@@ in the last line if it is truncated.
set display=truncate

" Show a few lines of context around the cursor.  Note that this makes the
" text scroll if you mouse-click near the start or end of the window.
set scrolloff=5

" Do incremental searching when it's possible to timeout.
if has('reltime')
  set incsearch
endif

" Do not recognize octal numbers for Ctrl-A and Ctrl-X, most users find it
" confusing.
set nrformats-=octal

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries.
if has('win32')
  set guioptions-=t
endif

" In many terminal emulators the mouse works just fine.  By enabling it you
" can position the cursor, Visually select and scroll with the mouse.
" Only xterm can grab the mouse events when using the shift key, for other
" terminals use ":", select text and press Esc.
if has('mouse')
  if &term =~ 'xterm'
    set mouse=a
  else
    set mouse=nvi
  endif
endif

set number
set splitbelow
set splitright
set clipboard=unnamed,unnamedplus

" Window switching mappings
nnoremap sj <c-w>j
nnoremap sk <c-w>k
nnoremap sl <c-w>l
nnoremap sh <c-w>h
" In terminal
" DEPRECATED. Not very POSIX/UNIX like to use an emulated term
" in your text editor. Use tmux instead
"tnoremap <c-j> <c-w>j
"tnoremap <c-k> <c-w>k
"tnoremap <c-l> <c-w>l
"tnoremap <c-h> <c-w>h

" go to start of line and visual select to end
"nnoremap vv V
"nnoremap V  vg_
nnoremap Y  yg_

" Fast scrolling
nnoremap J 5gj
nnoremap K 5gk
xnoremap J 5gj
xnoremap K 5gk


" visual line moving. Helpful when wrapping
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Going to file opens a tab instead of switching the buffer
nnoremap gf <c-w>gf

" No use for Q
map Q <nop>

" paste in insert mode
inoremap <c-p> <esc>pa
cnoremap <c-p> <c-r>"

" YOLO
set nobackup
set nowritebackup
set noswapfile

"--------BASIC CONFIG END-------------

"--------PLUGINS BEGIN----------------
call plug#begin()

Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-surround'
Plug '~/github/help-me.vim/'
Plug 'kana/vim-smartword'

call plug#end()


"--------PLUGINS END------------------
"--------PLUGIN SPECIFIC CONF---------

" Use smartword plugin instead of default 
" For horizontal traversal
nmap w  <Plug>(smartword-w)
nmap b  <Plug>(smartword-b)
nmap e  <Plug>(smartword-e)
nmap ge <Plug>(smartword-ge)

"--------PLUGIN SPECIFIC CONF END---------
"---------ADVANCED CONFIG BEGIN-------
let mapleader = ","
nnoremap <leader>m :w\|:silent make\|redraw!\|cw<CR>

" Enable man.vim plugin. This comes natively with vim in
" its runtime path
runtime! ftplugin/man.vim
" open man pages in a vertical window
let g:ft_man_open_mode="vert"
" go to manual on cursor
" This fucking sucks
" Need to do this so I can specify the man section I want
function! ManSect() range
  exe "Man " v:count1 expand("<cword>")
endfunction
nnoremap gm :call ManSect()<CR>
"---------ADVANCED CONFIG END---------

call helpme#Add("rrhubenov/test_help_me")


