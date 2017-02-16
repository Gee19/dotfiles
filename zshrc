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
antibody bundle bhilburn/powerlevel9k

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(vcs dir)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time virtualenv)
POWERLEVEL9K_STATUS_OK_BACKGROUND="black"
POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
POWERLEVEL9K_STATUS_ERROR_BACKGROUND="black"
POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
POWERLEVEL9K_VIRTUALENV_BACKGROUND="red"
POWERLEVEL9K_STATUS_VERBOSE=true

# include aliases
[[ -s ~/.aliases ]] && source ~/.aliases
