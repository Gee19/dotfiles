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
- elixir install breaks rabbitmq-server, test setup_env changes with --fix-missing
- add cucumber tbone test mapping
- write a tbone wrapper plugin
  - 1 keymap for test current buffer, 1 keymap for send line to pane
  - capture input for direction if last pane doesn't exist
  - define test commands mapping for filetype, or auto determine if possible
  - `let g:gbone_ft_map = {'python': 'pytest -vv', 'javascript': 'yarn test'}`
- try unfog + unfog.vim
- read:
  - https://iturbe.info/2017/10/the-command-line-productivity-triad-vimwiki-taskwarrior-timewarrior/
  - https://www.reddit.com/r/vim/comments/lj1vm9/replacing_orgmode_and_orgroam_with_vim/gn8ef5e/?context=3
  - vimwiki + taskwarrior vs unfog vs neuron.vim
