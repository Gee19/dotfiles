source <(antibody init)
antibody bundle < ~/.plugins.txt

[[ -s ~/.aliases ]] && source ~/.aliases

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=~/Envs
    mkdir -p $WORKON_HOME
    source /usr/local/bin/virtualenvwrapper.sh
fi

DISABLE_AUTO_TITLE="true"

autoload -Uz promptinit;promptinit
autoload -Uz compinit;compinit
kitty + complete setup zsh | source /dev/stdin

# max execution time of a process before its run time is shown when it exits
PURE_CMD_MAX_EXEC_TIME=10

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export BAT_THEME='TwoDark'
export FZF_COMPLETION_OPTS='--preview "(bat --color=never --style=numbers {} || cat {} || tree -C {}) 2> /dev/null | head -50"'
export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --follow --glob "!{.git,node_modules,static_common,*.xml,*.txt,*.csv,*.nessus,*.json"'

# fbr - checkout git branch (including remote branches), sorted by most recent commit, limit 30 last branches
fbr() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

bindkey -s '^b' 'fbr\n'
bindkey -s '^o' 'vim $(fzf)\n'
