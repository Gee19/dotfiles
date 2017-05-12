# Set up Antibody
source <(antibody init)
antibody bundle < ~/.plugins.txt

# Turn on completions
autoload -Uz compinit
compinit

# virtualenv environments
if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    export WORKON_HOME=~/Envs
    mkdir -p $WORKON_HOME
    source /usr/local/bin/virtualenvwrapper.sh
fi

# zsh pls
DISABLE_AUTO_TITLE="true"

# theme yo
antibody bundle mafredri/zsh-async
antibody bundle sindresorhus/pure

# include aliases
[[ -s ~/.aliases ]] && source ~/.aliases
