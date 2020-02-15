## Shell
- kitty
- zsh + antibody

`brew install zsh antibody`

`chsh -s /bin/zsh`

## Editor(s)
- vim/neovim + coc.nvim

`brew install neovim --HEAD`

`:PlugInstall`

`:CocInstall coc-prettier coc-python coc-json coc-css coc-tsserver coc-eslint coc-omnisharp coc-actions`

## Symlink dotfiles from homedir
`python install.py`

# Python
`pip install flake8==3.7.8 flake8-docstrings pydocstyle==4.0.1`

## Node
`brew install node yarn`

`npm install -g n`

## Extras
`brew install fzf ripgrep bat exa fd`

## TODO
- nvm
- automate Brewfile
