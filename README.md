## Term
- Ubuntu -> kitty
- Windows (WSL2) -> winterm -> debian -> kitty

## Shell
- zsh + znap
- tmux + tpm

## Editor
- neovim/vim + coc.nvim

## Setup
`ssh/gpg key magic`

`sudo apt install git`

`mkdir -p ~/dev && cd ~/dev`

`git clone git@github.com:Gee19/dotfiles.git && cd dotfiles`

`./setup_env.sh`

`XDG_CONFIG_HOME=/home/jhaine/.config python3 install.py`

`chsh -s /usr/bin/zsh`

`sudo cp /home/jhaine/.local/kitty.app/lib/kitty/terminfo/x/xterm-kitty /usr/share/terminfo/x/`

## TODO
- fix elixir env. install breaks rabbitmq-server
