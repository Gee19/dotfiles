## Shell
- kitty
- zsh + antibody

`brew install zsh antibody`

`chsh -s /bin/zsh`

## Editor (requires Node + fzf)
- neovim + vim-plug + coc.nvim

`brew install utf8proc neovim --HEAD`
- https://github.com/neovim/neovim/issues/11125
- https://github.com/Homebrew/homebrew-core/pull/45426

`:PlugInstall`

`:CocInstall coc-prettier coc-python coc-json coc-css coc-tsserver coc-eslint coc-pairs`

## Symlink dotfiles from homedir
`python install.py`

## Node
`brew install node yarn`

`npm install -g n`

## Extras
`brew install fzf ripgrep bat exa fd`
