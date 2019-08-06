set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'neoclide/coc.nvim', {'branch': 'master'}
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx',
Plug 'PeterRincker/vim-searchlight'
call plug#end()

hi Pmenu ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#64666d gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#204a87 gui=NONE
command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 Jsonfmt :%!python -m json.tool

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob "!sigma/static_common/*"'
  let g:ctrlp_use_caching = 0
endif

set hidden
set expandtab
set smarttab
set shiftround
set autoindent
set smartindent
set number
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
set cmdheight=2
set signcolumn=yes
set updatetime=300
set colorcolumn=120
set timeoutlen=1000 ttimeoutlen=0

if !isdirectory($HOME . "/.vim/undodir")
    call mkdir($HOME . "/.vim/undodir", "p")
endif
set undofile
set undodir=~/.vim/undodir
set backspace=indent,eol,start

set virtualedit+=block
noremap j gj
noremap k gk

let mapleader = "\<Space>"
nmap <C-k> :bnext<CR>
nmap <C-j> :bprevious<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

map <C-e> :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 25

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType javascript.jsx setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType scss setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType css setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType json setlocal tabstop=2 shiftwidth=2 softtabstop=2
