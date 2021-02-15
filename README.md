## Shell
- zsh + antibody

## Editor(s)
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
- antibody is deprecated.. should static load plugins
- .config bare repo (should fix antibody dep)
- coc -> nvim lsp when its more mature
