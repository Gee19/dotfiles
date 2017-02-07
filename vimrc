set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle.vim/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'ctrlpvim/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'vim-airline/vim-airline'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

set hidden

set timeoutlen=1000 ttimeoutlen=0
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>

filetype plugin indent on
syntax on

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