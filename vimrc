" Install vim-plug if it doesn't exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins
call plug#begin()
Plug 'mikejakobsen/One-Dark-Operator-Mono'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx',
Plug 'PeterRincker/vim-searchlight'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

let g:coc_node_path = '/usr/local/bin/node'

" Colors
syntax on
let g:onedark_termcolors=256
colorscheme onedark

" Fix bg color on scroll
autocmd VimEnter * hi Normal ctermbg=none

" Completion menu styling
hi Pmenu ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#64666d gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#204a87 gui=NONE

" vim-airline
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'

" Use ripgrep for vim :grep
if executable('rg')
  set grepprg=rg\ --no-heading\ --color=always\ --column\ --line-number
  set grepformat=%f:%l:%c:%m
endif

" fzf ripgrep preview
let $BAT_THEME = 'TwoDark'
command! -bang -nargs=* Rg
      \ call fzf#vim#grep('rg --column --no-heading --line-number --color=always '.shellescape(<q-args>),
      \ 1,
      \ fzf#vim#with_preview({'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}),
      \ <bang>0)

" Cool stuff
set hidden
set expandtab
set smarttab
set shiftround
set autoindent
set number
set nobackup
set nowritebackup
set noswapfile
set autoread
set ignorecase
set smartcase
set showmatch
set hlsearch
set incsearch
set gdefault
set cmdheight=2
set signcolumn=yes
set updatetime=300
set colorcolumn=120
set timeoutlen=1000 ttimeoutlen=0

" Create undodir if it doesn't exist
if !isdirectory($HOME . "/.vim/undodir")
    call mkdir($HOME . "/.vim/undodir", "p")
endif

" Enable undofile
set undofile
set undodir=~/.vim/undodir

" Backspace in insert mode
set backspace=indent,eol,start

" Move cursor by display lines when wrapping
set virtualedit+=block
noremap j gj
noremap k gk

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

" Commands
command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 Jsonfmt :%!python -m json.tool

" Binds
let mapleader = "\<Space>"
nmap <C-k> :bnext<CR>
nmap <C-j> :bprevious<CR>

" Yank to global clipboard (requires vim +clipboard)
map <leader>y "*y

nnoremap <leader><S-c> Oconsole.info();<Esc>
nnoremap <leader><S-p> Oimport pdb; pdb.set_trace()<Esc>
nnoremap <leader><S-r> Ofrom celery.contrib import rdb; rdb.set_trace()<Esc>

" fzf ripgrep
nnoremap <leader><S-f> :Rg<Cr>

" fzf files in cwd
nnoremap <C-f> :Files<Cr>

" fzf all files in repo
nnoremap <C-p> :GitFiles<Cr>

" Coc Binds
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocActionAsync('doHover')
  endif
endfunction

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Indenting
filetype plugin indent on
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4
autocmd FileType javascript.jsx setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType scss setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType css setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType json setlocal tabstop=2 shiftwidth=2 softtabstop=2
autocmd FileType asciidoc setlocal tabstop=2 shiftwidth=2 shiftwidth=2 softtabstop=2

" Prevent vim from indenting newlines
function! IndentIgnoringBlanks(child)
  let lnum = v:lnum
  while v:lnum > 1 && getline(v:lnum-1) == ""
    normal k
    let v:lnum = v:lnum - 1
  endwhile
  if a:child == ""
    if ! &l:autoindent
      return 0
    elseif &l:cindent
      return cindent(v:lnum)
    endif
  else
    exec "let indent=".a:child
    if indent != -1
      return indent
    endif
  endif
  if v:lnum == lnum && lnum != 1
    return -1
  endif
  let next = nextnonblank(lnum)
  if next == lnum
    return -1
  endif
  if next != 0 && next-lnum <= lnum-v:lnum
    return indent(next)
  else
    return indent(v:lnum-1)
  endif
endfunction
command! -bar IndentIgnoringBlanks
            \ if match(&l:indentexpr,'IndentIgnoringBlanks') == -1 |
            \   if &l:indentexpr == '' |
            \     let b:blanks_indentkeys = &l:indentkeys |
            \     if &l:cindent |
            \       let &l:indentkeys = &l:cinkeys |
            \     else |
            \       setlocal indentkeys=!^F,o,O |
            \     endif |
            \   endif |
            \   let b:blanks_indentexpr = &l:indentexpr |
            \   let &l:indentexpr = "IndentIgnoringBlanks('".
            \   substitute(&l:indentexpr,"'","''","g")."')" |
            \ endif
command! -bar IndentNormally
            \ if exists('b:blanks_indentexpr') |
            \   let &l:indentexpr = b:blanks_indentexpr |
            \ endif |
            \ if exists('b:blanks_indentkeys') |
            \   let &l:indentkeys = b:blanks_indentkeys |
            \ endif
augroup IndentIgnoringBlanks
  au!
  au FileType * IndentIgnoringBlanks
augroup END
