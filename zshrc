# vim: set tabstop=2 shiftwidth=2 foldmethod=marker:
# zmodload zsh/zprof

# znap plugins {{{
source ~/zsh/znap-repos/zsh-snap/znap.zsh
znap prompt "sindresorhus/pure"
znap source "mafredri/zsh-async"
znap source "zsh-users/zsh-completions"
znap source "zsh-users/zsh-autosuggestions"
znap source "zdharma-continuum/fast-syntax-highlighting"
znap source "zsh-users/zsh-history-substring-search"

zstyle ':znap:*' git-maintenance off
# }}}

# globals {{{
DISABLE_AUTO_TITLE="true"
PURE_CMD_MAX_EXEC_TIME=10
ZSH_AUTOSUGGEST_USE_ASYNC='true'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

zstyle ':completion:*' menu select
zmodload zsh/complist

_comp_options+=(globdots) # Include hidden files

if [ "$TERM" = "xterm-kitty" ]; then
  if test -n "$KITTY_INSTALLATION_DIR"; then
      autoload -Uz -- "$KITTY_INSTALLATION_DIR"/shell-integration/zsh/kitty-integration
      kitty-integration
      unfunction kitty-integration
  fi
fi

# Colored output in man pages
function man() {
  LESS_TERMCAP_md=$'\e[01;31m' \
  LESS_TERMCAP_me=$'\e[0m' \
  LESS_TERMCAP_se=$'\e[0m' \
  LESS_TERMCAP_so=$'\e[01;44;33m' \
  LESS_TERMCAP_ue=$'\e[0m' \
  LESS_TERMCAP_us=$'\e[01;32m' \
  command man "$@"
}

# flan autocomplete setup
FLAN_AC_ZSH_SETUP_PATH=$HOME/.cache/@sdelements/flan/autocomplete/zsh_setup && test -f $FLAN_AC_ZSH_SETUP_PATH && source $FLAN_AC_ZSH_SETUP_PATH
# }}}

# vi mode {{{
bindkey -v
export KEYTIMEOUT=1

# Yank to the system clipboard
function vi-yank-os-agnostic () {
  zle vi-yank
  if [ -n "$WSLENV" ]; then
    echo "$CUTBUFFER" | clip.exe
  else
    echo "$CUTBUFFER" | xclip -in -selection clipboard
  fi
}

zle -N vi-yank-os-agnostic
bindkey -M vicmd 'y' vi-yank-os-agnostic

# Dependencies for vim status + colours
zmodload zsh/zle
autoload -U colors && colors

# Change prompt icon + color based on insert/normal vim mode in prompt
export PURE_PROMPT_SYMBOL="[I] ❯"
export PURE_PROMPT_VICMD_SYMBOL="%{$fg[green]%}[N] ❯%{$reset_color%}"

# By default, we have insert mode shown on right hand side
# export RPROMPT="%{$fg[blue]%}[INSERT]%{$reset_color%}"
export RPROMPT=""

# Callback for vim mode change
function zle-keymap-select () {
  # Only supported in these terminals
  if [ "$TERM" = "xterm-256color" ] || [ "$TERM" = "xterm-kitty" ] || [ "$TERM" = "screen-256color" ]; then
    if [ $KEYMAP = vicmd ]; then
      # Command mode
      # export RPROMPT="%{$fg[green]%}[NORMAL]%{$reset_color%}"

      # Set block cursor
      echo -ne '\e[1 q'
    else
      # Insert mode
      # export RPROMPT="%{$fg[blue]%}[INSERT]%{$reset_color%}"

      # Set beam cursor
      echo -ne '\e[5 q'
    fi
  fi

  if typeset -f prompt_pure_update_vim_prompt_widget > /dev/null; then
    # Refresh prompt and call Pure super function
    prompt_pure_update_vim_prompt_widget
  fi
}

zle -N zle-keymap-select
zle-line-init() {
  zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
  echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# ci"
autoload -U select-quoted
zle -N select-quoted
for m in visual viopp; do
  for c in {a,i}{\',\",\`}; do
    bindkey -M $m $c select-quoted
  done
done

# ci{, ci(, di{ etc..
autoload -U select-bracketed
zle -N select-bracketed
for m in visual viopp; do
  for c in {a,i}${(s..)^:-'()[]{}<>bB'}; do
    bindkey -M $m $c select-bracketed
  done
done

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
# }}}

# fzf {{{
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export BAT_THEME='TwoDark'
export FZF_COMPLETION_OPTS='--info=inline'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude .yarn --exclude .firebase --exclude sde-content'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd -t d"

# pipe fzf output to vim if non-zero exit code
# TODO: not possible to use --exit-0 and --select-1 in interactive mode?
function vzf() {
  local fname
  fname=$(fzf-tmux -d 15)

  if [ -n "$fname" ]; then
    $EDITOR "$fname"
  fi
  return
}
bindkey -s '^o' 'vzf\n'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
function _fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
function _fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# docker {{{
# Shell into docker container
function dsh () {
  docker exec -i -t $1 /bin/bash
}

function _dsh(){
  containers=("${(@f)$(docker ps --format '{{.Names}}')}")
  compadd $containers
}

compdef _dsh dsh

# what if.. we were to go even further beyond
function dcsh() {
  local git_dir_folder
  git_dir_folder=$(echo "${$(git rev-parse --show-toplevel)##*/}_")

  local cons=$(docker-compose ps | rg $git_dir_folder | awk '{print $1}' | sed -e "s/$(echo $git_dir_folder)//" | sed -e 's/_1//')

  local selected_container
  selected_container=$(echo $cons | fzf)
  if [ -n "$selected_container" ]; then
    docker-compose exec $selected_container bash
  fi
  return
}

# Select a running docker container to stop
function ds() {
  local cid
  cid=$(docker ps | sed 1d | fzf -q "$1" | awk '{print $1}')

  [ -n "$cid" ] && docker stop "$cid"
}

# Select docker container(s) to remove
function drm() {
  docker ps -a | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $1 }' | xargs -r docker rm
}

# Select docker image(s) to remove
function drmi() {
  docker images | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }' | xargs -r docker rmi
}

# Select docker image to start bash tty
function drun() {
  image_id=$(docker image ls | sed 1d | fzf -q "$1" --no-sort -m --tac | awk '{ print $3 }')
  docker run -i -t --rm --user root $image_id bash
}
# }}}

# git {{{
function is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
function fbr() {
  is_in_git_repo || return
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

bindkey -s '^b' 'fbr\n'

# git stash diff
function gsd() {
  if [ "$1" != "" ]
  then
    git stash show -p stash@{$1}
  else
    git stash show -p stash@{0}
  fi
}

# git checkout pr
function gcopr() {
  if [ "$1" != "" ]
  then
    git fetch origin "refs/pull/$1/head:pr/$1" && git checkout "pr/$1"
  else
    return
  fi
}

alias glNoGraph='git log --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr% C(auto)%an" "$@"'
_gitLogLineToHash="echo {} | grep -o '[a-f0-9]\{7\}' | head -1"
_viewGitLogLine="$_gitLogLineToHash | xargs -I % sh -c 'git show --color=always % | bat'"

# fco - checkout git commit with previews
fco() {
  local commit
  commit=$( glNoGraph |
    fzf --no-sort --reverse --tiebreak=index --no-multi \
        --ansi --preview="$_viewGitLogLine" ) &&
  git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser with previews
fshow() {
    glNoGraph |
        fzf --no-sort --reverse --tiebreak=index --no-multi \
            --ansi --preview="$_viewGitLogLine" \
                --header "enter to view, alt-y to copy hash" \
                --bind "enter:execute:$_viewGitLogLine   | less -R" \
                --bind "alt-y:execute:$_gitLogLineToHash | xclip -in -selection clipboard"
}
# }}}
# }}}

# keybinds {{{
# ctrl + space for accept suggestion
bindkey '^ ' autosuggest-accept

# up/down for fuzzy history search (should use C-r more)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Use C-n C-p for up/down
bindkey '^N' history-substring-search-down
bindkey '^P' history-substring-search-up

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Old habits die hard
bindkey -M viins '\e\e[C' forward-word
bindkey -M viins '\e\e[D' backward-word
bindkey -M viins '^[^?' backward-kill-word
# }}}

# python {{{
# virtualenvwrapper
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=~/Envs
    mkdir -p $WORKON_HOME
    source /usr/local/bin/virtualenvwrapper.sh
fi

function gpip() {
  PIP_REQUIRE_VIRTUALENV=false pip "$@"
}
# }}}

# custom functions {{{
function rzsh() {
  if [ -n "$VIRTUAL_ENV" ]; then
    deactivate
  fi
  znap restart
  return
}

# i'll forget
function buildv() {
  if pidof $1; then
    echo "Found $1 PID(s), aborting.."
    exit 1
  fi

  if [[ "$1" == "nvim" ]]; then
    cd "$HOME/dev/neovim" && git pull
  else
    cd "$HOME/dev/$1" && git pull
  fi

  make clean && make distclean
  if [[ "$1" == "nvim" ]]; then
    make CMAKE_BUILD_TYPE=RelWithDebInfo
  else
    make
  fi
  sudo make install
  cd -
}

# copied from ohmyzsh
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line -w
  else
    zle push-input -w
    zle clear-screen -w
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
# }}}

# zprof
