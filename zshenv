SAVEHIST=1000000
HISTFILE=~/.zsh_history

local WORDCHARS='*?_[]~=&;!#$%^(){}<>'

[[ -s ~/.aliases ]] && source ~/.aliases

setopt share_history
setopt hist_expire_dups_first
setopt hist_find_no_dups

export HISTSIZE=100000
export HISTFILESIZE=100000
export EDITOR="nvim.appimage"
export VISUAL="nvim.appimage"

export XDG_CONFIG_HOME="$HOME/.config"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/.ripgreprc"
export PATH="$HOME/.local/bin:$PATH"

# Work
export DJANGO_SETTINGS_MODULE=settings
export PYTHONPATH=.
export sde_admin_repo_path="$HOME/dev/sde-admin/"
export sde_build_repo_path="$HOME/dev/sde-build/"

# Yava
export M2_HOME=/opt/maven
export MAVEN_HOME=/opt/maven
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
export PATH="${M2_HOME}/bin:${PATH}"

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Python
export VIRTUALENVWRAPPER_PYTHON=$(which python3)

# Node/nvm
# export NVM_DIR=~/.nvm
#  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" ]

export DOTNET_CLI_TELEMETRY_OPTOUT=true

export GITLAB_TOKEN=%NOPE%
