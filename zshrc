# zmodload zsh/zprof

# znap
source ~/zsh/znap-repos/zsh-snap/znap.zsh
znap prompt "sindresorhus/pure"
znap source "mafredri/zsh-async"
znap source "zsh-users/zsh-completions"
znap source "zsh-users/zsh-autosuggestions"
znap source "zsh-users/zsh-syntax-highlighting"
znap source "zsh-users/zsh-history-substring-search"
znap source "agkozak/zsh-z"

# virtualenvwrapper
if [ -f ${HOME}/.local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=~/Envs
    mkdir -p $WORKON_HOME
    source $HOME/.local/bin/virtualenvwrapper.sh
fi

DISABLE_AUTO_TITLE="true"
PURE_CMD_MAX_EXEC_TIME=10
ZSH_AUTOSUGGEST_USE_ASYNC='true'
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

zstyle ':completion:*' menu select
zmodload zsh/complist

_comp_options+=(globdots) # Include hidden files

if [ "$TERM" = "xterm-kitty" ]; then
  kitty + complete setup zsh | source /dev/stdin
fi

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Dependencies for vim status + colours
zmodload zsh/zle
autoload -U colors && colors

# Change prompt icon + color based on insert/normal vim mode in prompt
export PURE_PROMPT_SYMBOL="[I] ❯"
export PURE_PROMPT_VICMD_SYMBOL="%{$fg[green]%}[N] ❮%{$reset_color%}"

# By default, we have insert mode shown on right hand side
export RPROMPT="%{$fg[blue]%}[INSERT]%{$reset_color%}"

# Callback for vim mode change
function zle-keymap-select () {
    # Only supported in these terminals
    if [ "$TERM" = "xterm-256color" ] || [ "$TERM" = "xterm-kitty" ] || [ "$TERM" = "screen-256color" ]; then
        if [ $KEYMAP = vicmd ]; then
            # Command mode
            export RPROMPT="%{$fg[green]%}[NORMAL]%{$reset_color%}"

            # Set block cursor
            echo -ne '\e[1 q'
        else
            # Insert mode
            export RPROMPT="%{$fg[blue]%}[INSERT]%{$reset_color%}"

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

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export BAT_THEME='TwoDark'
export FZF_COMPLETION_OPTS='--preview "(bat --color=always --style=numbers {} || cat {} || tree -C {}) 2> /dev/null | head -50"'
export FZF_DEFAULT_COMMAND='rg --files'

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

bindkey -s '^b' 'fbr\n'

# pipe fzf output to vim if non-zero exit code
# TODO: not possible to use --exit-0 and --select-1 in interactive mode?
function vzf() {
    local fname
    fname=$(fzf) || ""
    [[ -z "$fname" ]] && return || nvim.appimage "$fname"
}
bindkey -s '^o' 'vzf\n'

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

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

if [ -n "$PS1" ] && [ -z "$TMUX" ]; then
  tmux new-session -A -s main
fi

# zprof
