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
Plug 'neoclide/coc.nvim', {'branch': 'master'}
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx',
Plug 'PeterRincker/vim-searchlight'
call plug#end()

command! -nargs=0 Prettier :CocCommand prettier.formatFile

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob "!sigma/static_common/*"'
  let g:ctrlp_use_caching = 0
endif

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

autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType javascript.jsx setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType scss setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType css setlocal tabstop=2 shiftwidth=2 softtabstop=2

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
