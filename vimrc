" vim-plug
call plug#begin('~/.vim/plugged')
" Theme
Plug 'joshdick/onedark.vim'

" tpope
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'

" Auto session management
Plug 'dhruvasagar/vim-prosession'

" Statusline and bufferline
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'

" Text Objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'glts/vim-textobj-comment'
Plug 'lucapette/vim-textobj-underscore'
Plug 'PeterRincker/vim-argumentative' " Argument text objects i, a, >,

" Syntax highlighting
Plug 'pangloss/vim-javascript', { 'for': [ 'javascript', 'typescript', 'javascriptreact', 'javascript.jsx'] }
Plug 'maxmellon/vim-jsx-pretty', { 'for': [ 'javascript', 'typescript', 'javascriptreact', 'javascript.jsx'] }
Plug 'HerringtonDarkholme/yats.vim', { 'for': [ 'typescriptreact', 'typescript' ] }

" Folds
Plug 'kalekundert/vim-coiled-snake'
Plug 'Konfekt/FastFold'

if has('nvim')
  Plug 'norcalli/nvim-colorizer.lua'
endif

" viM iSn'T aN IDe
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'rhysd/git-messenger.vim'
Plug 'airblade/vim-gitgutter'
Plug 'thirtythreeforty/lessspace.vim'
Plug 'rhysd/clever-f.vim'
Plug 'romainl/vim-qf'
Plug 'AndrewRadev/switch.vim'
Plug 'alvan/vim-closetag'
Plug 'Krasjet/auto.pairs'

" junegunn op
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/fzf.vim'

" Always load last
Plug 'ryanoasis/vim-devicons'
call plug#end()

colorscheme onedark

if exists('$SHELL')
  set shell=$SHELL
else
  set shell=/bin/sh
endif

if !has('nvim')
  syntax on
  let g:onedark_termcolors=256
  set encoding=UTF-8

  augroup vim_scroll_fix
    " Fix bg color on scroll
    autocmd!
    autocmd VimEnter * highlight Normal ctermbg=none
  augroup END
endif

if has('termguicolors')
  set termguicolors " Use true colours
endif

if has('nvim')
  " Operator Mono OP
  highlight Comment gui=italic
  highlight Comment cterm=italic
  highlight htmlArg gui=italic
  highlight htmlArg cterm=italic

  " nvim-colorizer
  lua require 'colorizer'.setup({'*', '!text'})
endif

augroup filetypes
  autocmd!
  autocmd BufRead,BufNewFile *.conf setlocal filetype=conf " Add conf filetype so nvim-colorizer works
  autocmd FileType cs setlocal tabstop=4 shiftwidth=4 " Fix c# indentation
augroup END

" Completion menu styling
highlight Pmenu ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#373d48 gui=NONE
highlight PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#204a87 gui=NONE

" Commit hash at 'Commit:' header with 'Special' highlight group
highlight link gitmessengerHash Special

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Lightline + Tabline
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified'] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }
let g:lightline#bufferline#show_number = 1
let g:lightline#bufferline#unnamed = '[No Name]'
let g:lightline.tabline = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type = {'buffers': 'tabsel'}

" Only show buffer filename
let g:lightline#bufferline#filename_modifier = ':t'

" Show devicons in bufferline
let g:lightline#bufferline#enable_devicons = 1

if !has('nvim')
  " Match tabline background color
  let s:palette = g:lightline#colorscheme#{g:lightline.colorscheme}#palette
  let s:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
  let s:palette.inactive.middle = s:palette.normal.middle
  let s:palette.tabline.middle = s:palette.normal.middle
endif

set hidden " New buffers with unsaved changes
set number " Line numbers
set noswapfile " No swap file on buffer load
set autoread " Auto read files changed outside of vim
set gdefault " Substitute all matches in a line
set cmdheight=2 " Better display for messages
set signcolumn=yes " Show left sidebar
set updatetime=100 " Fix coc diagnostic messages
set colorcolumn=120 " Long line warning
set timeoutlen=1500 ttimeoutlen=0 " Mapping and keycode delays
set showmatch " When a bracket is inserted, briefly jump to the matching one
set splitright " Open vplit buffer to the right
set laststatus=2 " Always show statusline
set showtabline=2 " Always show tabline
set linebreak " Avoid wrapping in middle of word
" set scrolloff=999 " Keep cursor in middle of screen when possible
set showbreak=↪ " Show this char when wrapping
set foldlevelstart=2 " Fold class methods
set foldmethod=indent " Fold based on indentation
set nofoldenable " Open all folds by default
set noshowmode " Hide mode, handled by lightline
set relativenumber " Show line numbers from current location
set shortmess+=c " don't give ins-completion-menu messages

if has('nvim')
  set inccommand=nosplit " Preview substitutions
endif

" Some coc servers have issues with backup files #649
set nobackup
set nowritebackup

" Don't persist folds in sessions (FastFold docs)
set sessionoptions-=folds

" Persist coc workspace folders in session file
set sessionoptions+=globals

" Indentation
filetype plugin indent on

set tabstop=4 " Interpret <TAB> as 4 spaces
set softtabstop=2 " 2 columns per tab
set shiftwidth=2 " Indent width

set expandtab " Convert tabs to spaces
set smarttab " Indent according to shiftwidth at beginning of line
set shiftround " Round indent to multiple of shiftwidth
set autoindent " Copy indent from current line when starting a new line

" Search
set ignorecase " Ignore case in search pattern
set smartcase " Override ignorecase if search contains uppercase
set hlsearch " Highlight previous search results
set incsearch " Match search terms incrementally

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

let g:closetag_filetypes='html,xhtml,jsx,xml,javascriptreact,javascript,typescriptreact,typescript'

" Colorful JS
let g:vim_jsx_pretty_colorful_config = 1

" NERDTree
let g:NERDTreeWinSize = 35
let NERDTreeIgnore = ['\.pyc$', '\.egg-info$', '^node_modules$']

" ryanoasis/vim-devicons/issues/243
" Fancy open/close icons for folders
" let g:DevIconsEnableFoldersOpenClose = 1

augroup nerdtree_fixes
  autocmd!

  " Never open in NERDTree buffer
  autocmd BufEnter * if bufname('#') =~ 'NERD_tree' && bufname('%') !~ 'NERD_tree' && winnr('$') > 1 | b# | exe "normal! \<c-w>\<c-w>" | :blast | endif

  " Close vi if NERDTree is last and only buffer
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

augroup goyo_limelight
  autocmd!
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!
augroup END

let mapleader = "\<Space>"

if has_key(g:plugs, 'coc.nvim')
  " let g:coc_force_debug = 1
  let g:coc_node_path = '/home/jhaine/.nvm/versions/node/v14.2.0/bin/node'

  let g:coc_global_extensions = [
    \ 'coc-prettier',
    \ 'coc-python',
    \ 'coc-json',
    \ 'coc-css',
    \ 'coc-tsserver',
    \ 'coc-eslint',
    \ 'coc-omnisharp',
    \ 'coc-actions',
    \ 'coc-rls'
  \ ]

  " use <tab> for trigger completion and navigate to the next completion item
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()

  " use shift-<tab> to navigate to previous completion item
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  " enter selects the first completion item and confirm the completion when no item has been selected
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

  " neoclide/coc.nvim/issues/28
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Prettier command
  command! -nargs=0 Prettier :CocCommand prettier.formatFile

  " Use K to show/hide documentation in preview window
  function! s:show_documentation() abort
    if coc#util#has_float()
      call coc#util#float_hide()
    elseif (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocActionAsync('doHover')
    endif
  endfunction

  " Coc Binds
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> K :call <SID>show_documentation()<CR>

  " Use `[c` and `]c` to navigate diagnostics
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)

  " Show all diagnostics
  nnoremap <silent><leader>d :<C-u>CocList diagnostics<cr>

  " Fix autofix problem of current line
  nmap <leader>cf <Plug>(coc-fix-current)

  " Remap for codeAction of selected region
  function! s:cocActionsOpenFromSelected(type) abort
    execute 'CocCommand actions.open ' . a:type
  endfunction

  xmap <silent> <leader>ca :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
  nmap <silent> <leader>ca :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@

  " Remap for rename current word
  nmap <leader>rn <Plug>(coc-rename)

endif

" Format JSON (TODO: jq & find more resilient method)
command! -nargs=0 Jsonfmt :%!python -m json.tool

if has('nvim')
  " Clear search highlighting with escape, broken in regular vim
  nnoremap <silent><esc> :noh<return><esc>

  " TextYankPost highlight
  function! s:hl_yank(operator, regtype, inclusive) abort
    if a:operator !=# 'y' || a:regtype ==# ''
      return
    endif
    " edge cases:
    "   ^v[count]l ranges multiple lines

    " TODO:
    "   bug: ^v where the cursor cannot go past EOL, so '] reports a lesser column.

    let bnr = bufnr('%')
    let ns = nvim_create_namespace('')
    call nvim_buf_clear_namespace(bnr, ns, 0, -1)

    let [_, lin1, col1, off1] = getpos("'[")
    let [lin1, col1] = [lin1 - 1, col1 - 1]
    let [_, lin2, col2, off2] = getpos("']")
    let [lin2, col2] = [lin2 - 1, col2 - (a:inclusive ? 0 : 1)]
    for l in range(lin1, lin1 + (lin2 - lin1))
      let is_first = (l == lin1)
      let is_last = (l == lin2)
      let c1 = is_first || a:regtype[0] ==# "\<C-v>" ? (col1 + off1) : 0
      let c2 = is_last || a:regtype[0] ==# "\<C-v>" ? (col2 + off2) : -1
      call nvim_buf_add_highlight(bnr, ns, 'TextYank', l, c1, c2)
    endfor
    call timer_start(300, {-> nvim_buf_is_valid(bnr) && nvim_buf_clear_namespace(bnr, ns, 0, -1)})
  endfunc
  highlight default link TextYank Visual
  augroup vimrc_hlyank
    autocmd!
    autocmd TextYankPost * call s:hl_yank(v:event.operator, v:event.regtype, v:event.inclusive)
  augroup END
endif

" XPS 2019 :(
nnoremap <PageUp> <Nop>
nnoremap <PageDown> <Nop>
inoremap <PageUp> <Nop>
inoremap <PageDown> <Nop>

" NERDTree
map <C-e> :NERDTreeToggle<CR>
map <leader>e :NERDTreeFind<CR>

" Yank to global clipboard (requires vim +clipboard)
map <leader>y "+y

" Vertically split screen
nnoremap <silent><leader>\ :vs<CR>

" Horizontally split screen
nnoremap <silent><leader>- :split<CR>

" beginning of the command line
cnoremap <C-a> <Home>

" end of the command line
cnoremap <C-e> <End>

" in insert mode
inoremap <C-e> <END>
inoremap <C-a> <HOME>

"splitting panes and moving around in panes
function! WinMove(key)
    let t:curwin = winnr()
    exec "wincmd ".a:key
    if (t:curwin == winnr())
        if (match(a:key,'[jk]'))
            wincmd v
        else
            wincmd s
        endif
        exec "wincmd ".a:key
    endif
endfunction

nnoremap <silent> <C-h> :call WinMove('h')<CR>
nnoremap <silent> <C-j> :call WinMove('j')<CR>
nnoremap <silent> <C-k> :call WinMove('k')<CR>
nnoremap <silent> <C-l> :call WinMove('l')<CR>

" Blink current search match
nnoremap <silent> n n:call <SID>BlinkCurrentMatch()<CR>
nnoremap <silent> N N:call <SID>BlinkCurrentMatch()<CR>

function! s:BlinkCurrentMatch()
  let target = '\c\%#'.@/
  let match = matchadd('IncSearch', target)
  redraw
  sleep 100m
  call matchdelete(match)
  redraw
endfunction

" Insert newline above or below and stay in normal mode
" No insert mode, doesn't move the cursor, and allows you to use a counter to append several lines at once
" Add 3 lines above: 3-leader-O
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

nnoremap <leader>C Oconsole.info();<Esc>hi
nnoremap <leader>P Oimport pdb; pdb.set_trace()<Esc>
nnoremap <leader>R Ofrom celery.contrib import rdb; rdb.set_trace()<Esc>

" Shift+U undo
nnoremap U :redo<cr>

" Make Y behave like other capitals
nnoremap Y y$

" Disable ex mode
nnoremap Q <Nop>

" Map j and k to gj/gk, but only when no count is given
" However, for larger jumps like 6j add the current position to the jump list
" so that you can use <c-o>/<c-i> to jump to the previous position
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

" Use ripgrep for vim :grep
if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" FZF
" Default preview off, only in fullscreen (Rg!)
let g:fzf_preview_window = ''

" ripgrep preview
let $BAT_THEME = 'TwoDark'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --no-heading --line-number --color=always --glob "!{.git,node_modules,static_common,*.xml,*.txt,*.csv,*.nessus,*.json,*.html,*.dll,*.cache,*.fvdl}" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2], 'options': '--layout=default'}, 'up:70%')
  \           : fzf#vim#with_preview({'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}, 'right:50%:hidden', '?'),
  \ <bang>0)

" files in git repo with changes, fullscreen if called with bang
command! -bang -nargs=* Gd call fzf#vim#gitfiles('?', {'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}, <bang>0)
nnoremap <silent> <leader>gd :Gd<cr>

" fullscreen ripgrep global search
nnoremap <silent> <leader><S-f> :Rg!<cr>

" fullscreen ripgrep global search current word
nnoremap <silent> <expr> <leader>f ":Rg!\ ".expand('<cword>')."<cr>"

" all files in repo
nnoremap <silent> <C-p> :GitFiles<cr>

" files in cwd
nnoremap <silent> <C-f> :Files<cr>

" buffers
nnoremap <silent> <leader>b :Buffers<cr>

" marks
nnoremap <silent> <leader>m :Marks<cr>

" commits of current buffer - kinda requires fugitive
nnoremap <silent> <leader>gl :BCommits!<cr>

" most recently updated files
nnoremap <silent> <leader>h :History<cr>

" lines in current buffer
nnoremap <silent> <leader>l :BLines<cr>

" lines in any buffer
nnoremap <silent> <leader>L :Lines<cr>

" help
nnoremap <silent> <leader>H :Helptags<cr>

" Reverse layout for floating windows
if has('nvim') || has('gui_running')
  let $FZF_DEFAULT_OPTS .= ' --inline-info --layout=reverse'
  let g:fzf_layout = { 'window': { 'width': 0.5, 'height': 0.3, 'yoffset': '-1', 'border': 'rounded' } }
endif

" Hide statusline when fzf open in vim
if !has('nvim')
  augroup fzf_statusline
    autocmd! FileType fzf
    autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
  augroup END
end

" Transparency
if has('nvim') && exists('&winblend') && has('termguicolors')
  set winblend=10

  if exists('g:fzf_colors.bg')
    call remove(g:fzf_colors, 'bg')
  endif
endif

" Jump to open buffer
let g:fzf_buffers_jump = 1

" vim-qf
nmap <leader>] <Plug>(qf_qf_next)
nmap <leader>[ <Plug>(qf_qf_previous)
nmap <leader>qf <Plug>(qf_qf_toggle)

" switch.vim
let g:switch_mapping = "<leader>s"

" vim-peekaboo
" let g:peekaboo_compact=1

" vim-gitgutter
let g:gitgutter_map_keys = 0
let g:gitgutter_grep = 'rg'
let g:gitgutter_preview_win_floating = 0

" highlight colours
highlight GitGutterAdd    guifg=#98c379 guibg=bg ctermfg=2 ctermbg=bg
highlight GitGutterChange guifg=#e5c07b guibg=bg ctermfg=3 ctermbg=bg
highlight GitGutterDelete guifg=#e06c75 guibg=bg ctermfg=1 ctermbg=bg

" mappings
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap gsh <Plug>(GitGutterStageHunk)
nmap guh <Plug>(GitGutterUndoHunk)

function! PreviewExists() abort
  for winnum in range(1, winnr('$'))
    if getwinvar(winnum, '&previewwindow')
      return 1
    endif
  endfor
  return 0
endfunction

" Toggle hunk preview
nnoremap <silent> gph :exe PreviewExists() ? 'pc' : 'GitGutterPreviewHunk'<CR>

" text objects
omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

augroup split_help
  autocmd!
  autocmd VimResized * wincmd = " Automatically equalize splits when resized
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif " vsplit new help buffers
augroup END

" Prevent vim from indenting newlines
" https://vim.fandom.com/wiki/Get_the_correct_indent_for_new_lines_despite_blank_lines
function! IndentIgnoringBlanks(child) abort
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
  autocmd!
  autocmd FileType * IndentIgnoringBlanks
augroup END
