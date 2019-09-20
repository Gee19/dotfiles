" vim-plug
call plug#begin()
Plug 'joshdick/onedark.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'pangloss/vim-javascript', { 'for': [ 'javascript', 'typescript', 'json', 'javascript.jsx', 'typescript.jsx' ] }
Plug 'mxw/vim-jsx', { 'for': [ 'javascript', 'typescript', 'json', 'javascript.jsx', 'typescript.jsx' ] }
Plug 'PeterRincker/vim-searchlight'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
call plug#end()

let g:coc_node_path = '/usr/local/bin/node'

" Colors
colorscheme onedark

" Operator Mono OP
highlight Comment gui=italic
highlight Comment cterm=italic
highlight htmlArg gui=italic
highlight htmlArg cterm=italic

" Completion menu styling
hi Pmenu ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#64666d gui=NONE
hi PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#204a87 gui=NONE

" Lightline + Tabline
let g:lightline = { 'colorscheme': 'onedark' }
let g:lightline#bufferline#show_number = 1
let g:lightline#bufferline#unnamed = '[No Name]'
let g:lightline.tabline = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type = {'buffers': 'tabsel'}

" Only show buffer filename
let g:lightline#bufferline#filename_modifier = ':t'

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

set hidden " New buffers with unsaved changes
set number " Line numbers
set noswapfile " No swap file on buffer load
set gdefault " Substitute all matches in a line
set cmdheight=2 " Better display for messages
set signcolumn=yes " Show left sidebar
set updatetime=300 " Fix coc diagnostic messages
set colorcolumn=120 " Long line warning
set timeoutlen=1000 ttimeoutlen=0 " Mapping and keycode delays
set showmatch " When a bracket is inserted, briefly jump to the matching one
set splitright " Open vplit buffer to the right
set showtabline=2 " Always show tabline
set linebreak " Avoid wrapping in middle of word
set inccommand=nosplit " Preview substitutions

" Some coc servers have issues with backup files #649
set nobackup
set nowritebackup

" Indentation
set expandtab " Convert tabs to spaces
set shiftround " Round indent to multiple of shiftwidth

" Search
set ignorecase " Ignore case in search pattern
set smartcase " Override ignorecase if search contains uppercase

" Enable undofile ($XDG_DATA_HOME/nvim/undo)
set undofile

" Move cursor by display lines when wrapping
set virtualedit+=block
noremap j gj
noremap k gk

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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
nmap <left> :bprevious<CR>
nmap <right> :bnext<CR>

" Yank to global clipboard (requires vim +clipboard)
map <leader>y "*y

nnoremap <leader><S-c> Oconsole.info();<Esc>
nnoremap <leader><S-p> Oimport pdb; pdb.set_trace()<Esc>
nnoremap <leader><S-r> Ofrom celery.contrib import rdb; rdb.set_trace()<Esc>

" lazy browsing
nnoremap <up> <c-u>
nnoremap <down> <c-d>

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

" vsplit help
augroup vimrc_help
  autocmd!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

" Indenting
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
