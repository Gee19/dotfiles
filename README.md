# Term
- kitty / winterm + wsl2

## Shell
- tmux + tpm
- zsh + antibody

## Editor
- neovim + coc.nvim

`:PlugInstall`

## Setup
`ssh key magic`

`mkdir -p ~/dev && cd ~/dev`

`git clone git@github.com:Gee19/dotfiles.git && cd dotfiles`

`./setup_env.sh`

`./update_nvim.sh`

`python3 install.py`

`chsh -s /usr/bin/zsh`

## TODO
- antibody is deprecated.. should static load plugins (zplug?)
- .config bare repo
  - should fix antibody dependency
  - simplifies `setup_env.sh`
- coc -> nvim lsp when its more mature
