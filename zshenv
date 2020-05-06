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
export DJANGO_SETTINGS_MODULE=settings
export PYTHONPATH=.
export sde_admin_repo_path='/Users/jhaine/dev/sde-admin/'
export sde_build_repo_path='/Users/jhaine/dev/sde-build/'

export NVM_DIR=~/.nvm
 [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

export HOMEBREW_NO_ANALYTICS=1
export DOTNET_CLI_TELEMETRY_OPTOUT=true

export GITLAB_TOKEN=%NOPE%
export CSC_KEY_PASSWORD=%NOPE%
