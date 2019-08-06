source <(antibody init)
antibody bundle < ~/.plugins.txt

[[ -s ~/.aliases ]] && source ~/.aliases

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=~/Envs
    mkdir -p $WORKON_HOME
    source /usr/local/bin/virtualenvwrapper.sh
fi

DISABLE_AUTO_TITLE="true"

antibody bundle mafredri/zsh-async
antibody bundle sindresorhus/pure

autoload -Uz promptinit;promptinit
autoload -Uz compinit;compinit

# max execution time of a process before its run time is shown when it exits
PURE_CMD_MAX_EXEC_TIME=10

export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --follow --glob "!{.git,node_modules,static_common}"'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

vf() {
  local file=$(fzf)
  if [ -n "$file" ]; then
    vim "$file"
  fi
}
