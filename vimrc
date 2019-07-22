set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
call plug#end()

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

set hidden

set timeoutlen=1000 ttimeoutlen=0
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>

if !isdirectory($HOME . "/.vim/undodir")
    call mkdir($HOME . "/.vim/undodir", "p")
endif
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
