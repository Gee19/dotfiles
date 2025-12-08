SAVEHIST=1000000
HISTFILE=~/.zsh_history

local WORDCHARS='*?_[]~=&;!#$%^(){}<>'

[[ -s ~/.aliases ]] && source ~/.aliases

setopt share_history
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt ignoreeof  # Same as setting IGNOREEOF=10 (Ctrl+d x10 to close shell)

export HISTSIZE=100000
export HISTFILESIZE=100000
export EDITOR="nvim"
export VISUAL="nvim"

export XDG_CONFIG_HOME="$HOME/.config"
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME/.ripgreprc"
export PATH="$HOME/.local/bin:$PATH"

# gpg tty, passphrases prob
export GPG_TTY=$(tty)

# Work
# export PYTHONPATH=.
export DJANGO_SETTINGS_MODULE=config.settings.base_settings
export sde_admin_repo_path="$HOME/dev/sde-admin/"
export sde_build_repo_path="$HOME/dev/sde-build/"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# Yava
export M2_HOME=/opt/maven
export MAVEN_HOME=/opt/maven
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk-amd64"
export PATH="${M2_HOME}/bin:${PATH}"

# Go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/env:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Python
export VIRTUALENVWRAPPER_PYTHON=$(which python3)

# Adding wsl-open as a browser for Windows
if [[ $(uname -r) =~ WSL2$ ]]; then
  if [[ -z $BROWSER ]]; then
    export BROWSER="wsl-open"
  fi
fi

# big brother
export DOTNET_CLI_TELEMETRY_OPTOUT=true
export NEXT_TELEMETRY_DISABLED=1

# Fix GitGutter CursorHold in vim
export VIM_GITGUTTER_TEST=1

# prevent the dreaded pip install -r requirements.txt in system python
# use gpip() instead
export PIP_REQUIRE_VIRTUALENV=true

# postgres local db
export PGUSER=sdlc
export PGPASSWORD=sdlc
