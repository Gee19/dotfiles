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
- coc -> nvim lsp when its more mature (https://github.com/Gee19/dotfiles/pull/5) idk i like regular vim too
- add xdotool to setup env
- bracketed paste broken in WSL2 (fixed in preview build microsoft/terminal/pull/9034#issuecomment-788151711)
- add cucumber tbone test mapping
