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
Plug 'itchyny/vim-gitbranch'
Plug 'mengelbrecht/lightline-bufferline'

" Text Objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'glts/vim-textobj-comment'
Plug 'lucapette/vim-textobj-underscore'

" Syntax highlighting
Plug 'pangloss/vim-javascript', { 'for': [ 'javascript', 'typescript', 'javascriptreact', 'javascript.jsx'] }
Plug 'maxmellon/vim-jsx-pretty', { 'for': [ 'javascript', 'typescript', 'javascriptreact', 'javascript.jsx'] }
Plug 'HerringtonDarkholme/yats.vim', { 'for': [ 'typescriptreact' ] }

" Folds
Plug 'kalekundert/vim-coiled-snake'
Plug 'Konfekt/FastFold'

" My fork of vim-backscratch with vnew default
Plug 'Gee19/vim-backscratch'

if has('nvim')
  Plug 'kizza/actionmenu.nvim' " A nice context menu for vim (coc code actions)
endif

" viM iSn'T aN IDe
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'rhysd/git-messenger.vim'
Plug 'airblade/vim-gitgutter'
Plug 'thirtythreeforty/lessspace.vim'
Plug 'rhysd/clever-f.vim'
Plug 'PeterRincker/vim-searchlight'
Plug 'PeterRincker/vim-argumentative'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'psliwka/vim-smoothie'
Plug 'romainl/vim-qf'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/fzf.vim'
Plug 'ryanoasis/vim-devicons' " Always load last
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
  lua require 'colorizer'.setup()
endif

augroup filetypes
  autocmd!
  autocmd BufRead,BufNewFile *.conf setlocal filetype=conf " Add conf filetype so nvim-colorizer works
  autocmd FileType cs setlocal tabstop=4 shiftwidth=4 " Fix c# indentation
augroup END

" Completion menu styling
highlight Pmenu ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#64666d gui=NONE
highlight PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#204a87 gui=NONE

" Commit hash at 'Commit:' header with 'Special' highlight group
highlight link gitmessengerHash Special

function! StatusDiagnostic() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, 'E' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, 'W' . info['warning'])
  endif
  return join(msgs, ' ')
endfunction

" Lightline + Tabline
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified', 'statusdiag'] ]
      \ },
      \ 'component_function': {
      \   'statusdiag': 'StatusDiagnostic',
      \   'gitbranch': 'gitbranch#name'
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
set timeoutlen=1000 ttimeoutlen=0 " Mapping and keycode delays
set showmatch " When a bracket is inserted, briefly jump to the matching one
set splitright " Open vplit buffer to the right
set laststatus=2 " Always show statusline
set showtabline=2 " Always show tabline
set linebreak " Avoid wrapping in middle of word
set scrolloff=999 " Keep cursor in middle of screen when possible
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

let mapleader = "\<Space>"

if has_key(g:plugs, 'coc.nvim')
  " let g:coc_force_debug = 1
  let g:coc_node_path = '/usr/local/n/versions/node/13.1.0/bin/node'

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

  " Code actions in context menu
  let s:code_actions = []

  function! ActionMenuCodeActions() abort
    let s:code_actions = CocAction('codeActions')
    let l:menu_items = map(copy(s:code_actions), { index, item -> item['title'] })
    call actionmenu#open(l:menu_items, 'ActionMenuCodeActionsCallback')
  endfunc

  function! ActionMenuCodeActionsCallback(index, item) abort
    if a:index >= 0
      let l:selected_code_action = s:code_actions[a:index]
      let l:response = CocAction('doCodeAction', l:selected_code_action)
    endif
  endfunc

  function! s:show_code_action_menu() abort
    if !has('nvim')
      nnoremap <leader>ca :<C-u>CocList actions<cr>
    endif

    if coc#util#has_float()
      call coc#util#float_hide()
    endif

    call ActionMenuCodeActions()
  endfunction

  " Show code actions
  nnoremap <silent><leader>ca :call <SID>show_code_action_menu()<CR>

endif

" Format JSON (TODO: jq)
command! -nargs=0 Jsonfmt :%!python -m json.tool

" Binds
nmap <left> :bprevious<CR>
nmap <right> :bnext<CR>

if has('nvim')
  " Clear search highlighting with escape, broken in regular vim
  nnoremap <silent><esc> :noh<return><esc>
endif

" vim-smoothie
let g:smoothie_no_default_mappings = v:true
nmap <C-d> <Plug>(SmoothieDownwards)
nmap <C-u> <Plug>(SmoothieUpwards)
nmap <S-Down> <Plug>(SmoothieForwards)
nmap <S-Up> <Plug>(SmoothieBackwards)

" NERDTree
map <C-e> :NERDTreeToggle<CR>
map <leader>e :NERDTreeFind<CR>

" Yank to global clipboard (requires vim +clipboard)
map <leader>y "*y

" Vertically split screen
nnoremap <silent><leader>\ :vs<CR>
" Split screen
nnoremap <silent><leader>- :split<CR>

" Easier movement between split windows CTRL + {h, j, k, l}
nnoremap <c-h> <c-w>h
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l

" Insert newline above or below and stay in normal mode
" No insert mode, doesn't move the cursor, and allows you to use a counter to append several lines at once
" Add 3 lines above: 3-leader-O
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

nnoremap <leader>C Oconsole.info();<Esc>
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

" Highlight last inserted text
nnoremap gV `[V`]

" Ctrl+a goes to the beginning of the command line
cnoremap <C-a> <Home>

" Ctrl+e goes to the end of the command line
cnoremap <C-e> <End>

" FZF
if has('nvim') || has('gui_running')
  let $FZF_DEFAULT_OPTS .= ' --inline-info --layout=reverse'
endif

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


augroup fzf_statusline
  " Terminal buffer options for fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set noshowmode noruler nonu
augroup END

if has('nvim') && exists('&winblend') && has('termguicolors')
  set winblend=10 " Transparency

  if exists('g:fzf_colors.bg')
    call remove(g:fzf_colors, 'bg')
  endif

  if stridx($FZF_DEFAULT_OPTS, '--border') == -1
    let $FZF_DEFAULT_OPTS .= ' --border --margin=0,2'
  endif

  function! CreateCenteredFloatingWindow() abort
      let width = float2nr(&columns * 0.6)
      let height = float2nr(&lines * 0.6)
      let top = ((&lines - height) / 2) - 1
      let left = (&columns - width) / 2
      let opts = {'relative': 'editor', 'row': top, 'col': left, 'width': width, 'height': height, 'style': 'minimal'}

      let top = "╭" . repeat("─", width - 2) . "╮"
      let mid = "│" . repeat(" ", width - 2) . "│"
      let bot = "╰" . repeat("─", width - 2) . "╯"
      let lines = [top] + repeat([mid], height - 2) + [bot]
      let s:buf = nvim_create_buf(v:false, v:true)
      call nvim_buf_set_lines(s:buf, 0, -1, v:true, lines)
      call nvim_open_win(s:buf, v:true, opts)
      set winhl=Normal:Floating
      let opts.row += 1
      let opts.height -= 2
      let opts.col += 2
      let opts.width -= 4
      call nvim_open_win(nvim_create_buf(v:false, v:true), v:true, opts)
      au BufWipeout <buffer> exe 'bw '.s:buf
  endfunction

  let g:fzf_layout = { 'window': 'call CreateCenteredFloatingWindow()' }
endif

" Use ripgrep for vim :grep
if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" fzf ripgrep preview
let $BAT_THEME = 'TwoDark'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --no-heading --line-number --color=always --glob "!{.git,node_modules,static_common,*.xml,*.txt,*.csv,*.nessus,*.json,*.html,*.dll,*.cache}" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2], 'options': '--layout=default'}, 'up:70%')
  \           : fzf#vim#with_preview({'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}, 'right:50%:hidden', '?'),
  \ <bang>0)

" fzf + ripgrep: global search
nnoremap <silent> <expr> <leader><S-f> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Rg!\<cr>"

" fzf + ripgrep: global search current word
nnoremap <silent> <expr> <leader>f (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Rg!\ ".expand('<cword>')."<cr>"

" fzf all files in repo
nnoremap <silent> <expr> <C-p> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":GitFiles\<cr>"

" fzf files in cwd
nnoremap <silent> <expr> <C-f> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"

" fzf buffers
nnoremap <silent> <expr> <leader>b (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Buffers\<cr>"

" fzf marks
nnoremap <silent> <expr> <leader>m (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Marks\<cr>"

" fzf commits of current buffer - kinda requires fugitive
nnoremap <silent> <expr> <leader>bc (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":BCommits!\<cr>"

" fzf most recently updated files
nnoremap <silent> <expr> <leader>h (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":History\<cr>"

" vim-qf
nmap <leader>] <Plug>(qf_qf_next)
nmap <leader>[ <Plug>(qf_qf_previous)
nmap <leader>qf <Plug>(qf_qf_toggle)

" vim-peekaboo
" let g:peekaboo_compact=1

" vim-gitgutter
let g:gitgutter_map_keys = 0
let g:gitgutter_grep = 'rg'
let g:gitgutter_preview_win_floating = 0

" highlight colours
highlight GitGutterAdd    guifg=#98c379 guibg=0 ctermfg=2 ctermbg=0
highlight GitGutterChange guifg=#e5c07b guibg=0 ctermfg=3 ctermbg=0
highlight GitGutterDelete guifg=#e06c75 guibg=0 ctermfg=1 ctermbg=0

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
