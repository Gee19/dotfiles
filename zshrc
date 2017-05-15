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

autoload -Uz promptinit; promptinit
prompt pure
autoload -Uz compinit; compinit
