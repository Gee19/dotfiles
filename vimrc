" vim: set tabstop=2 shiftwidth=2 foldmethod=marker:

" disable some built-ins (might want shada/netrw) {{{
let g:loaded_shada_plugin=1
let g:loaded_netrwPlugin=1
let g:loaded_gzip=1
let g:loaded_man=1
let g:loaded_matchit=1
let g:loaded_matchparen=1
let g:loaded_tarPlugin=1
let g:loaded_tar=1
let g:loaded_zipPlugin=1
let g:loaded_zip=1
" }}}

" vim-plug {{{
call plug#begin('~/.vim/plugged')
" Theme
Plug 'joshdick/onedark.vim'

" tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
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
Plug 'towolf/vim-helm'
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'elixir-editors/vim-elixir'

if has('nvim')
  Plug 'norcalli/nvim-colorizer.lua'
endif

" Folds
Plug 'Konfekt/FastFold'
Plug 'kalekundert/vim-coiled-snake'

" i made this
Plug 'Gee19/indent-ignoreblank.vim' " Get the correct indent for new lines despite blank lines

" viM iSn'T aN IDe
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'rhysd/git-messenger.vim'
Plug 'airblade/vim-gitgutter'
" Plug 'thirtythreeforty/lessspace.vim'
Plug 'tweekmonster/wstrip.vim'
Plug 'rhysd/clever-f.vim'
Plug 'romainl/vim-qf'
Plug 'AndrewRadev/switch.vim'
Plug 'alvan/vim-closetag'
Plug 'Krasjet/auto.pairs'
Plug 'Vimjas/vim-python-pep8-indent', { 'for': [ 'python' ] }
Plug 'rhysd/conflict-marker.vim' " [x ]x to navigate merge conflicts
Plug 'christoomey/vim-tmux-navigator'
Plug 'antoinemadec/FixCursorHold.nvim'
Plug 'jesseleite/vim-agriculture'
Plug 'moll/vim-bbye'
Plug 'preservim/vimux'

" junegunn op
Plug 'junegunn/fzf', { 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-peekaboo'

" nerd fonts broken in wsl
let s:in_wsl = system("uname -r") =~ "WSL"
if !(s:in_wsl)
  Plug 'ryanoasis/vim-devicons' " Always load last
endif

call plug#end()
" }}}

" shell/colorscheme/grepprg {{{
if has('termguicolors')
  set termguicolors " Use true colours
endif

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

colorscheme onedark

if exists('$SHELL')
  set shell=$SHELL
else
  set shell=/bin/sh
endif

" Format JSON (TODO: jq & find more resilient method)
command! -nargs=0 Jsonfmt :%!python -m json.tool

" Use ripgrep for vim :grep
if executable('rg')
  set grepprg=rg\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif
" }}}

" vim only {{{
if !has('nvim')
  syntax on
  let g:onedark_termcolors=256
  set encoding=UTF-8

  " Match tabline background color
  autocmd VimEnter * call SetupLightlineColors()
  function SetupLightlineColors() abort
    " transparent background in statusbar
    let l:palette = lightline#palette()

    let l:palette.normal.middle = [ [ 'NONE', 'NONE', 'NONE', 'NONE' ] ]
    let l:palette.inactive.middle = l:palette.normal.middle
    let l:palette.tabline.middle = l:palette.normal.middle

    call lightline#colorscheme()
  endfunction

  augroup vim_scroll_fix
    " Fix bg color on scroll
    autocmd!
    autocmd VimEnter * highlight Normal ctermbg=none
  augroup END
endif
" }}}

" neovim only {{{
if has('nvim')
  " https://github.com/neovim/neovim/issues/12587
  " leave updatetime untouched (and avoid unnecessary swap writes)
  let g:cursorhold_updatetime = 100

  " Operator Mono OP
  highlight Comment gui=italic
  highlight Comment cterm=italic
  highlight htmlArg gui=italic
  highlight htmlArg cterm=italic

  " Preview substitutions
  set inccommand=nosplit

  " nvim-colorizer
  lua require 'colorizer'.setup({'*', '!text'})

  " Clear search highlighting with escape x2
  nnoremap <silent><esc><esc> :nohlsearch<CR>
endif
" }}}

" autocmds {{{
augroup filetypes
  autocmd!
  autocmd BufRead,BufNewFile *.conf setlocal filetype=conf " Add conf filetype so nvim-colorizer works
  autocmd FileType cs setlocal tabstop=4 shiftwidth=4 " Fix c# indentation
augroup END

augroup pysnips
  autocmd!
  autocmd FileType python :iabbrev <buffer> pdb import pdb; pdb.set_trace()<Esc>
  autocmd FileType python :iabbrev <buffer> rdb from celery.contrib import rdb; rdb.set_trace()<Esc>
augroup END

augroup newline_formatting
  autocmd!
  autocmd BufNewFile,BufRead * set formatoptions-=c formatoptions-=r formatoptions-=o
augroup END

augroup split_help
  autocmd!
  autocmd VimResized * wincmd = " Automatically equalize splits when resized
  " autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif " vsplit new help buffers
augroup END

augroup yank_highlight
  autocmd!
  autocmd TextYankPost * if exists('##TextYankPost') | exe "silent! lua require'vim.highlight'.on_yank()" | endif
augroup END
" }}}

" Lightline + Tabline {{{
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'tpope_op', 'filename', 'modified'] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'tpope_op': 'FugitiveHead'
      \ },
      \ }

let g:lightline#bufferline#show_number = 1
let g:lightline#bufferline#unnamed = '[No Name]'
let g:lightline.tabline = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type = {'buffers': 'tabsel'}

" Only show buffer filename
let g:lightline#bufferline#filename_modifier = ':t'

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Show devicons in bufferline when not in WSL
if !(s:in_wsl)
  let g:lightline#bufferline#enable_devicons = 1
endif
" }}}

" global vars {{{
set hidden " New buffers with unsaved changes
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
set showbreak=↪ " Show this char when wrapping
set foldlevelstart=2 " Fold class methods
set foldmethod=indent " Fold based on indentation
set nofoldenable " Open all folds by default
set noshowmode " Hide mode, handled by lightline
set shortmess+=c " don't give ins-completion-menu messages
set number " Line numbers
set relativenumber " Show line numbers from current location
set scrolloff=5 " Keep X lines above/below cursor when near edge of screen
set mouse=a " Enable mouse support in 'all' modes, fixes scrolling tmux history
set wildignorecase " Ignore case when completing file names and directories
set iskeyword+=- " treat dash-separated-words as word text object

" Some coc servers have issues with backup files #649
set nobackup
set nowritebackup

" enable bracketed paste when used within tmux
" https://vi.stackexchange.com/a/28284
if &term =~ "screen"
    let &t_BE = "\e[?2004h"
    let &t_BD = "\e[?2004l"
    exec "set t_PS=\e[200~"
    exec "set t_PE=\e[201~"
endif

set sessionoptions-=folds " Don't persist folds in sessions (FastFold docs)
let g:fastfold_savehook = 0 " folds are only updated manually but not when saving the buffer
let g:fastfold_fold_command_suffixes = [] " folds are not updated when closing or opening with mappings

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

" Backspace in insert mode
set backspace=indent,eol,start

" Move cursor by display lines when wrapping
set virtualedit+=block

" Create undodir if it doesn't exist
if !isdirectory($HOME . "/.vim/undodir")
  call mkdir($HOME . "/.vim/undodir", "p")
endif

" Enable undofile
set undofile
set undodir=~/.vim/undodir

" Enable wstrip on buffer save globally for all filetypes
let g:wstrip_auto = 1
" }}}

" mappings {{{
let mapleader = "\<Space>"

" Toggle between no numbers -> absolute -> relative with absolute on cursor line
nnoremap <C-n> :let [&nu, &rnu] = [!&rnu, &nu+&rnu==1]<CR>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Don't let x and c to spoil the yank register
nnoremap x "_x
nnoremap c "_c

" Don't jump to next occurrence of search when using */g* (doesn't pollute registers/jump list)
nnoremap <silent><expr> * v:count ? '*'
      \ : ':execute "keepjumps normal! *" <Bar> call winrestview(' . string(winsaveview()) . ')<CR>'
nnoremap <silent><expr> g* v:count ? 'g*'
      \ : ':execute "keepjumps normal! g*" <Bar> call winrestview(' . string(winsaveview()) . ')<CR>'

" always center the screen after any movement command
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" go to end of yanked text
vnoremap <silent> y y`]

" simple sizing of splits
map - <C-W>-
map + <C-W>+

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

" Paste from global clipboard (requires vim +clipboard)
map <leader>p "*p

" Toggle word wrapping
map <leader>w :set wrap!<CR>

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

" Quickly append semicolon or comma
imap ;; <Esc>A;<Esc>
imap ,, <Esc>A,<Esc>

" splitting panes and moving around in panes
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

nnoremap <silent> <leader>h :call WinMove('h')<CR>
nnoremap <silent> <leader>j :call WinMove('j')<CR>
nnoremap <silent> <leader>k :call WinMove('k')<CR>
nnoremap <silent> <leader>l :call WinMove('l')<CR>

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

" switch.vim
let g:switch_mapping = "<leader>s"

" Vimux
if exists('$TMUX')
  let g:VimuxRunnerName = "vimuxout"

  augroup vimux_maps
    autocmd!
    autocmd FileType python map <buffer> <leader>tt :call VimuxRunCommand("clear; pytest -vv " . expand('%:p'))<CR>
    " autocmd FileType cucumber map <leader>tt :RunAllCukes<CR>
  augroup END

  nnoremap <silent> <leader>tp :VimuxPromptCommand<CR>
  nnoremap <silent> <leader>to :VimuxOpenRunner<CR>
  nnoremap <silent> <leader>tq :VimuxCloseRunner<CR>
endif
" }}}

" styling {{{
" Completion menu styling
highlight Pmenu ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#373d48 gui=NONE
highlight PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#204a87 gui=NONE

" Commit hash at 'Commit:' header with 'Special' highlight group
highlight link gitmessengerHash Special

let g:closetag_filetypes='html,xhtml,jsx,xml,javascriptreact,javascript,typescriptreact,typescript'

" Colorful JS
let g:vim_jsx_pretty_colorful_config = 1
" }}}

" NERDTree {{{
let g:NERDTreeWinSize = 35
let NERDTreeIgnore = ['\.pyc$', '\.egg-info$', '^node_modules$']

augroup nerdtree_fixes
  autocmd!

  " Never open in NERDTree buffer
  autocmd BufEnter * if bufname('#') =~ 'NERD_tree' && bufname('%') !~ 'NERD_tree' && winnr('$') > 1 | b# | exe "normal! \<c-w>\<c-w>" | :blast | endif

  " Close vi if NERDTree is last and only buffer
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END
" }}}

" coc.nvim {{{
if has_key(g:plugs, 'coc.nvim')
  " let g:coc_force_debug = 1

  " disable coc startup warning in vim
  if !has('nvim')
    let g:coc_disable_startup_warning = 1
  endif

  " node paths for my separate environments
  if (s:in_wsl)
    let g:coc_node_path = '/usr/bin/node'
  else
    let g:coc_node_path = '/home/jhaine/.nvm/versions/node/v14.16.0/bin/node'
  endif

  " coc-java requires manual install of jdt-ls
  " neoclide/coc-java/issues/99
  let g:coc_global_extensions = [
    \ 'coc-prettier',
    \ 'coc-pyright',
    \ 'coc-json',
    \ 'coc-css',
    \ 'coc-tsserver',
    \ 'coc-eslint',
    \ 'coc-omnisharp',
    \ 'coc-actions',
    \ 'coc-rls',
    \ 'coc-java',
    \ 'coc-yaml',
    \ 'coc-lua',
    \ 'coc-elixir'
  \ ]

  " use <tab> for trigger completion and navigate to the next completion item
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()

  " use shift-<tab> to navigate to previous completion item
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  " enter selects the first completion item and confirm the completion when no item has been selected
  " inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

  " same as above but fixes coc + endwise conflict
  " tpope/vim-endwise/issues/125
  inoremap <silent> <CR> <C-r>=<SID>coc_confirm()<CR>
  function! s:coc_confirm() abort
    if pumvisible()
      return coc#_select_confirm()
    else
      return "\<C-g>u\<CR>"
    endif
  endfunction

  " neoclide/coc.nvim/issues/28
  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Prettier command
  command! -nargs=0 Prettier :CocCommand prettier.formatFile

  " Use K to show/hide documentation in preview window
  function! s:show_documentation()
    if coc#float#has_float()
      call coc#float#close_all()
    elseif (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
    else
      execute '!' . &keywordprg . " " . expand('<cword>')
    endif
  endfunction

  " Coc Binds
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <silent> K :call <SID>show_documentation()<CR>

  " Use `[c` and `]c` to navigate diagnostics
  nmap <silent> [d <Plug>(coc-diagnostic-prev)
  nmap <silent> ]d <Plug>(coc-diagnostic-next)

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
" }}}

" FZF {{{
" Default preview off, only in fullscreen (Rg!)
let g:fzf_preview_window = ''

" ripgrep preview
let $BAT_THEME = 'TwoDark'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --no-heading --line-number --color=always --glob "!{*.lock}" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options':'--layout=default --delimiter : --nth 4..', 'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}, 'up:70%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..', 'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}, 'right:50%:hidden', '?'),
  \ <bang>0)

" files in git repo with changes, fullscreen if called with bang
command! -bang -nargs=* Gd call fzf#vim#gitfiles('?', {'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}, <bang>0)
nnoremap <silent> <leader>gd :Gd<cr>

" fullscreen ripgrep global search
nnoremap <silent> <leader><S-f> :Rg!<cr>

" agriculture
nmap <leader><S-r> <Plug>RgRawSearch
vmap <leader>/ <Plug>RgRawVisualSelection
nmap <leader>* <Plug>RgRawWordUnderCursor

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
nnoremap <silent> <leader>H :History<cr>

" lines in current buffer
nnoremap <silent> <leader>cb :BLines<cr>

" lines in any buffer
nnoremap <silent> <leader>ab :Lines<cr>

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
" }}}

" clever-f {{{
let g:clever_f_across_no_line = 1 " only span 1 line
let g:clever_f_fix_key_direction = 1 " always force f->forward F->backward

" Keep functionality of ; & ,
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)
" }}}

" vim-qf {{{
nmap q] <Plug>(qf_qf_next)
nmap q[ <Plug>(qf_qf_previous)
nmap <C-q> <Plug>(qf_qf_toggle)

nmap <leader>] <Plug>(qf_loc_next)
nmap <leader>[ <Plug>(qf_loc_previous)
nmap <leader>q <Plug>(qf_loc_toggle)
" }}}

" vim-gitgutter {{{
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
" }}}
