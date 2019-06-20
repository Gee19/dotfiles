set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'w0rp/ale'
Plugin 'vim-airline/vim-airline'

call vundle#end()

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

set hidden

set timeoutlen=1000 ttimeoutlen=0
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>

filetype plugin indent on
syntax on

set undofile
set undodir=~/.vim/undodir
set backspace=indent,eol,start

set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set smarttab
set shiftround
set autoindent
set smartindent
set number
set colorcolumn=120

map <C-e> :NERDTreeToggle<CR> 
let g:NERDTreeWinSize = 25

set nobackup
set nowritebackup
set noswapfile
set hidden
set autoread

set ignorecase 
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault

set virtualedit+=block

noremap j gj
noremap k gk
