## Term
- Ubuntu: kitty
- Windows: winterm preview + wsl2

## Shell
- zsh + znap
- tmux + tpm

## Editor (starts in ~35ms, notbad.jpg)
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
- elixir install breaks rabbitmq-server
- add cucumber tbone test mapping
- tmux bind for notes window
- try these as well:
  - vimwiki (vimwiki/vimwiki)
  - wiki.vim (lervag/wiki.vim)
  - vim-dotoo (dhruvasagar/vim-dotoo)
