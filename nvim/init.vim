"e $MYVIMRC--------BASIC CONFIG BEGIN-------------

filetype plugin indent on
syntax on

" Allow backspacing over everything in insert mode.
set backspace=indent,eol,start

set history=1000	" keep 200 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line
set wildmode=full
set undofile
set hlsearch
set incsearch
set laststatus=2
set colorcolumn=80

" Cursorline on only the current window
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END


set tabstop=8 softtabstop=0
set shiftwidth=4 smarttab
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

" Using C-j C-k to going up & down the menus
" inoremap <expr> <TAB> pumvisible() ? "\<C-y>" : "\<TAB>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Space> pumvisible() ? "\<C-y> " : "\<Space>"
"inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"
inoremap <expr> <C-d> pumvisible() ? "\<PageDown>" : "\<C-d>"
inoremap <expr> <C-u> pumvisible() ? "\<PageUp>" : "\<C-u>"

" Tab switching mappings
nnoremap st gT
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

" open definition in another split
" nmap <silent> gvd :vsplit<CR>gd

" YOLO
set nobackup
set nowritebackup
set noswapfile

"--------BASIC CONFIG END-------------

"--------PLUGINS BEGIN----------------
call plug#begin()

" Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-surround'
Plug 'kana/vim-smartword'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Setup function called in treesitter.lua
Plug 'nvim-treesitter/nvim-treesitter-context'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'sainnhe/everforest'
Plug 'sainnhe/sonokai'
Plug 'morhetz/gruvbox'
" Plug 'psliwka/vim-smoothie'

" Autocompletion
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'

Plug 'VonHeikemen/lsp-zero.nvim', {'branch': 'v3.x'}

" Telescope (Plenery is some sort of lib for async code)
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'commit': '0.1.8' }

" Git
Plug 'tpope/vim-fugitive'
Plug 'sindrets/diffview.nvim'

" Zig
Plug 'ziglang/zig.vim'

" Golang
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Copilot
Plug 'github/copilot.vim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'

call plug#end()

"--------PLUGINS END------------------
"
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
  exe "vertical Man " v:count1 expand("<cword>")
endfunction
nnoremap gm :call ManSect()<CR>

" Remove highlight by pressing CR
nnoremap <silent> <cr> :noh<cr><cr>
"---------ADVANCED CONFIG END---------
"---------COLORSCHEME--------------
" Important!!
if has('termguicolors')
  set termguicolors
endif

if exists('+termguicolors')
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
endif

" For dark version.
"set background=dark
"set background=light

"---- EVERFOREST -----
" Set contrast.
" This configuration option should be placed before `colorscheme everforest`.
" Available values: 'hard', 'medium'(default), 'soft'
"let g:everforest_background = 'soft'
"
"let g:everforest_dim_inactive_windows = 1
"" For better performance
"let g:everforest_better_performance = 1

"colorscheme everforest

"---- SONOKAI -----
"let g:sonokai_style = 'atlantis'
"let g:sonokai_dim_inactive_windows = 1
"let g:sonokai_better_performance = 1

"colorscheme sonokai

let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox

"-------FZF--------
"nnoremap <c-f> :RG<CR>
"tnoremap <c-f> <c-c>

"-------- LUA CONFIG -----------
lua require('init')
lua require('zig')
lua require('smartword')
lua require('treesitter')
lua require('go')
lua require('copilot')


"-----------NETRW CONFIG----------
let g:netrw_winsize = 20
let g:netrw_liststyle=3
let g:netrw_banner = 0
let g:netrw_sort_options = "i"
nnoremap <c-l> :Lexplore<CR>
autocmd filetype netrw noremap <buffer> sl <c-w>l
autocmd filetype netrw noremap <buffer> <c-l> :q<CR>


nnoremap J 5gj
nnoremap K 5gk
xnoremap J 5gj
xnoremap K 5gk

