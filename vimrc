" vim: set tabstop=2 shiftwidth=2 foldmethod=marker:
" built-ins  {{{
let g:loaded_netrwPlugin=1
let g:loaded_gzip=1
let g:loaded_man=1
let g:loaded_tarPlugin=1
let g:loaded_tar=1
let g:loaded_zipPlugin=1
let g:loaded_zip=1

" enable cfilter and matchit plugins
packadd! cfilter
packadd! matchit
" }}}
" vim-plug {{{
call plug#begin('~/.vim/plugged')
" Theme
Plug 'joshdick/onedark.vim'
if has('nvim')
  Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'p00f/nvim-ts-rainbow'
endif

" tpope
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-tbone'

" me
Plug 'Gee19/vim-gbone'
Plug 'Gee19/vim-coiled-snake' " kalekundert/vim-coiled-snake/issues/34
Plug 'Gee19/lessspace.vim' " Added toggle func
Plug 'Gee19/vim-peekaboo' " Fixes conflict with lessspace
let g:peekaboo_window='vert bo 40new'

" gbone dependency
Plug 'tyru/current-func-info.vim'

" Auto session management
Plug 'dhruvasagar/vim-prosession'

" Statusline, bufferline and buffers
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'moll/vim-bbye' " Delete buffers without affecting layout

" Text Objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'glts/vim-textobj-comment'
Plug 'kana/vim-textobj-function'
Plug 'PeterRincker/vim-argumentative' " Argument text objects i, a, >,

" Whatever doesn't have a treesitter parser..
Plug 'towolf/vim-helm'
Plug 'Vimjas/vim-python-pep8-indent'

" Folds
Plug 'Konfekt/FastFold'

" viM iSn'T aN IDe
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
Plug 'christoomey/vim-tmux-navigator'
Plug 'scrooloose/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'farmergreg/vim-lastplace'
Plug 'alvan/vim-closetag'

" inkarkat
" {register}-gr-{motion} dot repeatable
Plug 'inkarkat/vim-ReplaceWithRegister'
Plug 'inkarkat/vim-ReplaceWithSameIndentRegister'
Plug 'inkarkat/vim-visualrepeat'

" AndrewRadev / tags
Plug 'AndrewRadev/switch.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'AndrewRadev/tagalong.vim'

" neovim/neovim/issues/12587
Plug 'antoinemadec/FixCursorHold.nvim'
let g:cursorhold_updatetime = 100 " leave updatetime untouched (and avoid unnecessary swap writes)

" git
Plug 'rhysd/conflict-marker.vim' " [x ]x to navigate merge conflicts
Plug 'rhysd/git-messenger.vim'
Plug 'rhysd/committia.vim'
Plug 'airblade/vim-gitgutter'

" grep/search & quickfix improvements
Plug 'rhysd/clever-f.vim'
Plug 'romainl/vim-qf'

" junegunn op
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" Always load last
Plug 'ryanoasis/vim-devicons'
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

let g:tokyonight_style = "night"
let s:scheme = has('nvim') ? 'tokyonight' : 'onedark'
let s:shell = exists('$SHELL') ? $SHELL : '/bin/sh'
execute 'colorscheme ' . s:scheme
execute 'set shell=' . s:shell

" Format JSON
command! -nargs=0 Jsonfmt :%!jq
command! -nargs=0 Jq :%!jq
command! D smile

" Use ripgrep for vim :grep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
else
  set grepprg=grep\ -nrH\ --exclude=tags\ --exclude-dir=.git\ --exclude-dir=node_modules
  set grepformat=%f:%l:%m
endif
" }}}
" vim only {{{
if !has('nvim')
  syntax on
  let g:onedark_termcolors=256
  set encoding=UTF-8

  " block cursor
  let &t_SI = "\e[6 q"
  let &t_SR = "\e[4 q"
  let &t_EI = "\e[2 q"

  " Fix GitGutter CursorHold
  autocmd VimEnter * call gitgutter#process_buffer(bufnr(''), 0)

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
  set jumpoptions=stack " Make the jumplist behave like the tagstack
  lua require('ts')
endif
" }}}
" autocmds {{{
augroup common
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
  autocmd FileType python :iabbrev <buffer> pdb import pdb; pdb.set_trace()<Esc>
  autocmd FileType python :iabbrev <buffer> rdb from celery.contrib import rdb; rdb.set_trace()<Esc>
  autocmd FileType css :iabbrev <buffer> centerme display: 'flex';<cr>justify-content: 'center';<cr>align-items: 'center';

  autocmd BufNewFile,BufRead * set formatoptions-=c formatoptions-=r formatoptions-=o " newline formatting
  autocmd VimResized * wincmd = " Automatically equalize splits when resized
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif " vsplit new help buffers
  autocmd TextYankPost * if exists('##TextYankPost') | exe "silent! lua require'vim.highlight'.on_yank()" | endif

  " set up default omnifunc
  autocmd FileType *
        \ if &omnifunc == "" |
        \    setlocal omnifunc=syntaxcomplete#Complete |
        \ endif
augroup END
" }}}
" Lightline + Tabline {{{
function FilenameWithMethod() abort
  let filename = expand('%')
  let cfunc = cfi#format('%s', '')
  if len(cfunc) > 0
    return filename . ' > ' . substitute(cfunc, '\.', ' > ', '')
  endif
  return filename
endfunction

let g:lightline = {
      \ 'colorscheme': s:scheme,
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'file_with_method', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status',
      \   'file_with_method': 'FilenameWithMethod',
      \ },
      \ }

let g:lightline#bufferline#show_number = 1
let g:lightline#bufferline#smart_path = 1
let g:lightline#bufferline#unnamed = '[Empty]'
let g:lightline.tabline = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type = {'buffers': 'tabsel'}

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Show devicons
let g:lightline#bufferline#enable_devicons = 1
" }}}
" global vars {{{
set clipboard^=unnamed,unnamedplus " Trying system clipboard & linux 'selection' clipboard
set path+=** " Search all directories recursively, * for fuzzy
set hidden " New buffers with unsaved changes
set noswapfile " No swap file on buffer load
set autoread " Auto read files changed outside of vim
set gdefault " Substitute all matches in a line
set cmdheight=2 " Better display for messages
set signcolumn=yes " Show left sidebar
set updatetime=100 " Fix coc diagnostic messages
set colorcolumn=120 " Long line warning
set timeoutlen=500 ttimeoutlen=0 " Mapping and keycode delays
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
set scrolloff=8 " Keep X lines above/below cursor when near edge of screen
set mouse=a " Enable mouse support in 'all' modes, fixes scrolling tmux history
set wildignorecase " Ignore case when completing file names and directories
set iskeyword+=- " treat dash-separated-words as word text object
set wildmenu " Enhanced tabline completion
set wildcharm=<C-z> " Use C-z for activating wildmenu in commands
set matchtime=2 " Time to show matching pair
set matchpairs+=<:> " Add <> to matchpairs

" don't syntax color long lines
" pretty sure this doesn't work with treesitter (vim only)
set synmaxcol=250
syntax sync minlines=256
syntax sync maxlines=256

" Some coc servers have issues with backup files #649
set nobackup
set nowritebackup

" enable bracketed paste when used within tmux
" :h xterm-bracketed-paste
if !has('gui_running') && !has('nvim') && exists('$TMUX')
  " Better mouse support, see  :help 'ttymouse'
  set ttymouse=sgr

  " Enable true colors, see  :help xterm-true-color
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  " Enable bracketed paste mode, see  :help xterm-bracketed-paste
  let &t_BE = "\<Esc>[?2004h"
  let &t_BD = "\<Esc>[?2004l"
  let &t_PS = "\<Esc>[200~"
  let &t_PE = "\<Esc>[201~"

  " Enable focus event tracking, see  :help xterm-focus-event
  let &t_fe = "\<Esc>[?1004h"
  let &t_fd = "\<Esc>[?1004l"
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

" undofiles are incompatible between vim & neovim..
" also can't set this to a variable for some reason..
if !has('nvim')
  if !isdirectory($HOME . "/.vim/undodir")
    call mkdir($HOME . "/.vim/undodir", "p")
  endif
  set undodir=~/.vim/undodir
else
  if !isdirectory($HOME . "/.config/nvim/undodir")
    call mkdir($HOME . "/.config/nvim/undodir", "p")
  endif
  set undodir=~/.config/nvim/undodir
endif
set undofile

" Yank absolute path to system clipboard
cabbrev yfp let @+=expand("%:p")<CR>

" Yank file name to system clipboard
cabbrev yfn let @+=expand("%:t")<CR>

" Bbye
cabbrev Bd Bdelete

" Plug
cabbrev PC PlugClean
cabbrev PI PlugInstall
cabbrev PU PlugUpdate
cabbrev CU CocUpdate
cabbrev CL CocList

" Quickfix
cabbrev cf Cfilter
" }}}
" mappings {{{
let mapleader = "\<Space>"

" Toggle between no numbers -> absolute -> relative with absolute on cursor line
nnoremap <C-n> :let [&nu, &rnu] = [!&rnu, &nu+&rnu==1]<CR>

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Don't let x, c or s spoil the yank register
for char in [ 'x', 'c', 's', 'X', 'C', 'S' ]
	execute 'nnoremap ' . char . ' "_' . char
	execute 'xnoremap ' . char . ' "_' . char
endfor

" Don't touch unnamed register when pasting over visual selection
xnoremap <expr> p 'pgv"' . v:register . 'y'

" Don't jump to next occurrence of search when using */g* (doesn't pollute registers/jump list)
nnoremap <silent><expr> * v:count ? '*'
      \ : ':execute "keepjumps normal! *" <Bar> call winrestview(' . string(winsaveview()) . ')<CR>'
nnoremap <silent><expr> g* v:count ? 'g*'
      \ : ':execute "keepjumps normal! g*" <Bar> call winrestview(' . string(winsaveview()) . ')<CR>'

" always center the screen after any movement command
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" NERDTree
map <C-e> :NERDTreeToggle<CR>
map <leader>e :NERDTreeFind<CR>

" Toggle word wrapping
map <leader>w :set wrap!<CR>

" beginning/end of the command line
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" in insert mode
inoremap <C-e> <END>
inoremap <C-a> <HOME>

" Clear search highlighting with escape x2
nnoremap <silent><esc><esc> :nohlsearch<CR>

" splitting panes and moving around in panes
function! WinMove(key) abort
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

nnoremap <silent> <C-w>h :call WinMove('h')<CR>
nnoremap <silent> <C-w>j :call WinMove('j')<CR>
nnoremap <silent> <C-w>k :call WinMove('k')<CR>
nnoremap <silent> <C-w>l :call WinMove('l')<CR>

" Insert newline above or below and stay in normal mode
" No insert mode, doesn't move the cursor, and allows you to use a counter to append several lines at once
" Add 3 lines above: 3-leader-O
nnoremap <silent> <leader>o :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> <leader>O :<C-u>call append(line(".")-1, repeat([""], v:count1))<CR>

" Shift+U redo
nnoremap U :redo<CR>

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

" spell
nnoremap <silent> <leader>S <cmd>setlocal spell!<CR>

" splitjoin.vim
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
nnoremap gss :SplitjoinSplit<cr>
nnoremap gsj :SplitjoinJoin<cr>

" Move lines up or down and fix indentation
nnoremap <A-k> :<C-u>silent! move-2<CR>==
nnoremap <A-j> :<C-u>silent! move+<CR>==
xnoremap <A-k> :<C-u>silent! '<,'>move-2<CR>gv=gv
xnoremap <A-j> :<C-u>silent! '<,'>move'>+<CR>gv=gv

" lessspace
nmap <C-s> <cmd>call lessspace#Toggle()<CR>

" i disable netrw (wsl-open handles WSL)
nnoremap <silent> gx <cmd>silent execute '!xdg-open ' . shellescape(expand('<cfile>'), 1)<CR>

" Use a bunch of standard UNIX commands for quick an dirty whitespace-based alignment
function! Align() abort
	'<,'>!column -t|sed 's/  \(\S\)/ \1/g'
	normal gv=
endfunction

xnoremap <silent> <leader>a :<C-u>silent call Align()<CR>
" }}}
" styling {{{
if !has('nvim')
  " Completion menu styling
  highlight Pmenu ctermfg=NONE ctermbg=236 cterm=NONE guifg=NONE guibg=#373d48 gui=NONE
  highlight PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE guifg=NONE guibg=#204a87 gui=NONE

  " Commit hash at 'Commit:' header with 'Special' highlight group
  highlight link gitmessengerHash Special

  " Git gutter
  highlight GitGutterAdd    guifg=#98c379 guibg=bg ctermfg=2 ctermbg=bg
  highlight GitGutterChange guifg=#e5c07b guibg=bg ctermfg=3 ctermbg=bg
  highlight GitGutterDelete guifg=#e06c75 guibg=bg ctermfg=1 ctermbg=bg
endif

" Italics (Operator Mono OP)
highlight Comment gui=italic
highlight Comment cterm=italic
highlight htmlArg gui=italic
highlight htmlArg cterm=italic
" }}}
" NERDTree {{{
let g:NERDTreeWinSize = 37
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
  let g:coc_force_debug = 1

  " try to use lang serv when tag jumping <C-]>
  set tagfunc=CocTagFunc

  " Use lang serv to format if available (! silences errors)
  set formatexpr=!CocActionAsync('formatSelected')

  " disable coc startup warning in vim
  if !has('nvim')
    let g:coc_disable_startup_warning = 1
  endif

  let g:coc_node_path = '/home/jhaine/.nvm/versions/node/v14.18.2/bin/node'

  " dropped coc-elixir,
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
    \ 'coc-rls',
    \ 'coc-java',
    \ 'coc-yaml',
    \ 'coc-sh',
    \ 'coc-react-refactor',
    \ 'coc-vimlsp',
    \ 'coc-sumneko-lua'
  \ ]

  " coc-vimlsp highlighting
  let g:markdown_fenced_languages = [
      \ 'vim',
      \ 'help'
      \]

  " wip
  set runtimepath^=/home/jhaine/dev/coc-cucumber

  " use <tab> for trigger completion and navigate to the next completion item
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()

  " use shift-<tab> to navigate to previous completion item
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  " enter selects the first completion item and confirm the completion when no item has been selected
  " fixes coc + endwise conflict
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

  " Use <c-space> to trigger completion.
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  " Prettier command
  command! -nargs=0 Prettier :CocCommand prettier.formatFile

  " Add `:Format` command to format current buffer
  command! -nargs=0 Format :call CocAction('format')

  " Add `:Fold` command to fold current buffer
  command! -nargs=? Fold :call CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer.
  " TODO: override this in python, use isort
  command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')

  " Use K to show/hide documentation in preview window
  function! s:show_documentation() abort
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

  " Highlight the symbol and its references when holding the cursor
  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Append to tagstack when jumping to definition, implementation or reference
  function! s:goto_tag(tagkind) abort
    let tagname = expand('<cword>')
    let winnr = winnr()
    let pos = getcurpos()
    let pos[0] = bufnr()

    if CocAction('jump' . a:tagkind)
      call settagstack(winnr, {
            \ 'curidx': gettagstack()['curidx'],
            \ 'items': [{'tagname': tagname, 'from': pos}]
            \ }, 't')
    endif
  endfunction

  " Coc Binds
  nmap <silent> gd <cmd>call <SID>goto_tag("Definition")<CR>
  nmap <silent> gi <cmd>call <SID>goto_tag("Implementation")<CR>
  nmap <silent> gR <cmd>call <SID>goto_tag("References")<CR>

  nmap <silent> gD <cmd>call CocAction('jumpDefinition', 'vsplit')<CR>
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> K <cmd>call <SID>show_documentation()<CR>

  " Use `[d` and `]d` to navigate diagnostics
  nmap <silent> [d <Plug>(coc-diagnostic-prev)
  nmap <silent> ]d <Plug>(coc-diagnostic-next)

  " Show all diagnostics
  nnoremap <silent><leader>d <cmd>CocList diagnostics<cr>

  " Show symbols in workspace
  nnoremap <silent><expr> <leader>fs "<cmd>CocList -I --input=".expand('<cword>')." symbols<cr>"
  nnoremap <silent><expr> <leader>fc "<cmd>CocList -I --input=".expand('<cword>')." symbols -kind Class<cr>"

  " Applying codeAction to the selected region.
  " Example: `<leader>aap` for current paragraph
  xmap <silent><leader>c  <Plug>(coc-codeaction-selected)
  nmap <silent><leader>c  <Plug>(coc-codeaction-selected)

  " Remap keys for applying codeAction to the current buffer.
  nmap <silent><leader>cG  <Plug>(coc-codeaction)

  " Fix autofix problem of current line
  nmap <silent><leader>cl <Plug>(coc-fix-current)

  " Remap for rename current word
  nmap <silent><leader>rn <Plug>(coc-rename)

  " Scroll floating window if it exists
  nnoremap <silent><expr> <PageUp> coc#float#has_scroll() ? coc#float#scroll(0, 1) : "\<PageUp>"
  nnoremap <silent><expr> <PageDown> coc#float#has_scroll() ? coc#float#scroll(1, 1) : "\<PageDown>"
  inoremap <silent><expr> <PageUp> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0, 1)\<cr>" : "\<PageUp>"
  inoremap <silent><expr> <PageDown> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1, 1)\<cr>" : "\<PageDown>"
  xnoremap <silent><expr> <PageUp> coc#float#has_scroll() ? coc#util#float_scroll_i(-1) : "\<PageUp>"
  xnoremap <silent><expr> <PageDown> coc#float#has_scroll() ? coc#util#float_scroll_i(1) : "\<PageDown>"
endif
" }}}
" FZF {{{
" Default preview off, only in fullscreen (Rg!)
let g:fzf_preview_window = ''

" ripgrep preview
" Ignoring filetypes here is annoying
let $BAT_THEME = 'TwoDark'
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --no-heading --line-number --color=always
  \   -g "!*.lock"
  \   -g "!*.sql"
  \   -g "!*.xml"
  \   -g "!package-lock.json" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options':'--layout=default --delimiter : --nth 4..', 'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}, 'up:70%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..', 'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}, 'right:50%:hidden', '?'),
  \ <bang>0)

" files in git repo with changes, fullscreen if called with bang
command! -bang -nargs=* Gd call fzf#vim#gitfiles('?', {'dir': system('git rev-parse --show-toplevel 2> /dev/null')[:-2]}, <bang>0)

" fullscreen ripgrep global search
nnoremap <silent> <leader><S-f> :Rg!<cr>

" fullscreen ripgrep global search current word
nnoremap <silent> <expr> <leader>f "<cmd>Rg!\ ".expand('<cword>')."<cr>"

" all files in repo
nnoremap <silent> <C-p> <cmd>GitFiles<cr>

" files in cwd
nnoremap <silent> <C-f> <cmd>Files<cr>

" buffers
nnoremap <silent> <leader>b <cmd>Buffers<cr>
" nnoremap <leader>b :buffer *
" nnoremap <leader>b :buffer<Space><C-R>=nr2char(&wildcharm)<CR><S-Tab>

" marks
nnoremap <silent> <leader>m <cmd>Marks<cr>

" commits of current buffer - kinda requires fugitive
nnoremap <silent> <leader>gl <cmd>BCommits!<cr>

" Reverse layout for floating windows
let $FZF_DEFAULT_OPTS .= ' --inline-info --layout=reverse'
let g:fzf_layout = { 'window': { 'width': 0.5, 'height': 0.3, 'yoffset': '-1', 'border': 'rounded' } }

" Transparency
if has('nvim') && exists('&winblend') && has('termguicolors')
  set winblend=10

  if exists('g:fzf_colors.bg')
    call remove(g:fzf_colors, 'bg')
  endif
endif

" Jump to open buffer
let g:fzf_buffers_jump = 1

" FZF Buffer Delete
function! s:list_buffers() abort
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines) abort
  " Use bdelete so buffers stay in locationlist
  " TODO: echo what was deleted?
  execute 'bdelete' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': {
  \   lines -> s:delete_buffers(lines)
  \ },
  \ 'options': '--prompt="Delete Buffer(s):" --multi --reverse --bind ctrl-a:select-all+accept'
  \ }))
" }}}
" FZF Session Picker {{{
let s:session_dir = '$HOME/.vim/session/'
function! s:list_sessions() abort
  return systemlist('ls ' . s:session_dir)
endfunction

function! s:source_session(line) abort
  exec 'source ' . s:session_dir . substitute(a:line[0], '%', '\\%', 'g')
endfunction

" TODO: Add ctrl-x to delete, ctrl-e to edit
command! SessionPicker call fzf#run(fzf#wrap({
  \ 'source': s:list_sessions(),
  \ 'sink*': { line -> s:source_session(line) },
  \ 'options': '--prompt="Source Session:" --reverse'
  \ }))
" }}}
" clever-f {{{
let g:clever_f_across_no_line = 1 " only span 1 line
let g:clever_f_fix_key_direction = 1 " always force f->forward F->backward

" Keep functionality of ; & ,
map ; <Plug>(clever-f-repeat-forward)
map , <Plug>(clever-f-repeat-back)
" }}}
" vim-qf {{{
nmap ]q <Plug>(qf_qf_next)
nmap [q <Plug>(qf_qf_previous)
nmap q] <Plug>(qf_qf_next)
nmap q[ <Plug>(qf_qf_previous)
nmap <C-q> <Plug>(qf_qf_toggle)

nmap <leader>] <Plug>(qf_loc_next)
nmap <leader>[ <Plug>(qf_loc_previous)
nmap ]<leader> <Plug>(qf_loc_next)
nmap [<leader> <Plug>(qf_loc_previous)
nmap <leader>q <Plug>(qf_loc_toggle)

let g:qf_mapping_ack_style = 1

" Disable these for async Grep
let g:qf_auto_open_quickfix = 0
let g:qf_auto_open_loclist = 0
" }}}
" auto resize qf {{{
function! AdjustWindowHeight(minheight, maxheight)
    let l = 1
    let n_lines = 0
    let w_width = winwidth(0)
    while l <= line('$')
        " number to float for division
        let l_len = strlen(getline(l)) + 0.0
        let line_width = l_len/w_width
        let n_lines += float2nr(ceil(line_width))
        let l += 1
    endw
    execute max([min([n_lines, a:maxheight]), a:minheight]) . "wincmd _"
endfunction

augroup qf_resize
  autocmd!
  au FileType qf call AdjustWindowHeight(3, 10)
augroup END
" }}}
" async grep: https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3{{{
command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost cgetexpr cwindow
  autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

" call grepprg in a system shell instead of internal shell
" async but loading into qf is synchronous =[
function! Grep(...) abort
    return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

function! TrimEscapeRegA() abort
  let query = getreg('a')
  let trimmedQuery = s:trim(query)
  let escapedQuery = shellescape(trimmedQuery, "'#%\\")
  call setreg('a', escapedQuery)
endfunction

function! s:trim(str) abort
  if exists('*trim')
    return trim(a:str)
  else
    return matchstr(a:str, '^\s*\zs.\{-}\ze\s*$')
  endif
endfunction
" }}}
" more quickfix {{{
command! ClearQuickfix cexpr []
command! -bar -nargs=* Jump cexpr system('git jump ' . expand(<q-args>))

" Normal: `dd` removes item from the quickfix list.
" Visual: `d` removes all selected items, gk keeps all selected items
augroup custom_qf_mapping
  autocmd!
  autocmd FileType qf nnoremap <buffer> dd :.Reject<CR>
  autocmd FileType qf xnoremap <buffer> d :'<,'>Reject<CR>
  autocmd FileType qf nnoremap <buffer> gk :.Keep<CR>
  autocmd FileType qf xnoremap <buffer> gk :'<,'>Keep<CR>
augroup END

" open quickfix with last search
nnoremap <silent> <leader>? :Grep <C-r>/<CR>

" async grep current visual selection
xnoremap <leader>/ "ay:call TrimEscapeRegA()<CR>:Grep <C-r>a<CR>

" async grep word under cursor
nnoremap <leader>* "ayiw:call TrimEscapeRegA()<CR>:Grep <C-r>a<CR>
" }}}
" mostly git related {{{
" committia.vim
let g:committia_hooks = {}
let g:committia_use_singlecolumn = 'fallback'
let g:committia_min_window_width = 110
function! g:committia_hooks.edit_open(info)
    setlocal spell

    " If no commit message, start with insert mode
    if a:info.vcs ==# 'git' && getline(1) ==# ''
        startinsert
    endif

    " Scroll the diff window from insert mode
    imap <buffer><Down> <Plug>(committia-scroll-diff-down-half)
    imap <buffer><Up> <Plug>(committia-scroll-diff-up-half)
endfunction

" vim-gitgutter
let g:gitgutter_map_keys = 0
let g:gitgutter_grep = 'rg'
let g:gitgutter_preview_win_floating = 0

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
" tbone/gbone {{{
if exists('$TMUX') && has_key(g:plugs, 'vim-tbone') && has_key(g:plugs, 'vim-gbone')
  let g:gbone_run_mapping = '<leader>x'
  let g:gbone_run_ft_map = {
  \ 'python': 'python3.8',
  \ 'javascript': 'node',
  \ }
  let g:gbone_repl_mapping = '<leader>rl'
  let g:gbone_test_mapping = '<leader>t'
  let g:gbone_ft_map = {
  \ 'python': 'pytest -vvv',
  \ 'javascript': 'yarn test',
  \ 'elixir': 'mix test',
  \ 'spec': 'npx cypress run --browser firefox --spec'
  \ }
  let g:gbone_ft_strategy = {
  \ 'python': 'smart',
  \ 'elixir': 'line',
  \ }
endif
" }}}
" tagalong / closetag {{{
let g:tagalong_verbose = 1
let g:closetag_filetypes='html,xhtml,xml,javascriptreact,typescriptreact'
" }}}
" romainl pseudo-text objects {{{
" https://gist.github.com/romainl/c0a8b57a36aec71a986f1120e1931f20

" 22 simple pseudo-text objects (, removed for argumentative)
" i_ i. i: i; i| i/ i\ i* i+ i- i#
" a_ a. a: a; a| a/ a\ a* a+ a- a#
for char in [ '_', '.', ':', ';', '<bar>', '/', '<bslash>', '*', '+', '-', '#' ]
	execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
	execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
	execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
	execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

" line pseudo-text objects | il al
xnoremap il g_o^
onoremap il :<C-u>normal vil<CR>
xnoremap al $o0
onoremap al :<C-u>normal val<CR>

" number pseudo-text object (integer and float) | in
function! VisualNumber()
	call search('\d\([^0-9\.]\|$\)', 'cW')
	normal v
	call search('\(^\|[^0-9\.]\d\)', 'becW')
endfunction
xnoremap in :<C-u>call VisualNumber()<CR>
onoremap in :<C-u>normal vin<CR>

" last change pseudo-text objects | ik ak
xnoremap ik `]o`[
onoremap ik :<C-u>normal vik<CR>
onoremap ak :<C-u>normal vikV<CR>
" }}}
