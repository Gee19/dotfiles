## Term
- Ubuntu: kitty
- Windows: winterm + wsl2

## Shell
- zsh + znap
- tmux + tpm

## Editor
- neovim/vim + coc.nvim

## Setup
`ssh key magic`

`mkdir -p ~/dev && cd ~/dev`

`git clone git@github.com:Gee19/dotfiles.git && cd dotfiles`

`./setup_env.sh`

`./update_nvim.sh`

`python3 install.py`

`chsh -s /usr/bin/zsh`

## TODO
- elixir install breaks rabbitmq-server, test setup_env changes with --fix-missing
- diffsitter?
