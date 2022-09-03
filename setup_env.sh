#!/bin/bash
set -e
sudo apt -y update && sudo apt -y dist-upgrade

# add-apt-repository / curl / wget / xdg-open / fuse
sudo apt -y install software-properties-common curl wget xdg-utils fuse git-lfs

# Conflicts with nodejs on debian
sudo apt remove nodejs-doc

# Vim 8.2
sudo add-apt-repository -y -r ppa:jonathonf/vim
sudo apt -y update

# Remove system vim (might need vim.tiny here)
sudo apt -y remove vim

# Node unzip zsh py3-pip tmux mosh vim
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
sudo apt -y install zsh unzip nodejs python3-pip tmux mosh vim-gtk3 gettext-base xclip

# Neovim build deps
sudo apt -y install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config doxygen

# TODO: fix this?
# TPM
if [[ -d "~/.tmux/plugins/tpm" ]]
then
  echo "Skipping tpm.."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Yarn
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt -y update && sudo apt -y install yarn

# Znap
if [[ -d "~/zsh/znap-repos/zsh-snap" ]]
then
  echo "Skipping znap.."
  git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git ~/zsh/znap-repos/zsh-snap
fi

mkdir -p ~/.config/nvim/lua
mkdir -p ~/.vim
mkdir -p ~/.local/bin
cd ~/.local/bin

# wsl-open
if [[ $(uname -r) =~ WSL2$ ]]; then
  wget "https://raw.githubusercontent.com/4U6U57/wsl-open/master/wsl-open.sh"
  mv wsl-open.sh wsl-open
  chmod +x wsl-open
fi

# jq
wget "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64"
mv ./jq-linux64 ~/.local/bin/jq
chmod +x ~/.local/bin/jq

# ijq
wget "https://git.sr.ht/~gpanders/ijq/refs/download/v0.3.6/ijq-0.3.6-linux-x86_64.tar.gz"
tar xzvf ijq-0.3.6-linux-x86_64.tar.gz
mv ijq-0.3.6/ijq ~/.local/bin/ijq
rm ijq-0.3.6-linux-x86_64.tar.gz
rm -rf ijq-0.3.6

# EXA
wget "https://github.com/ogham/exa/releases/download/v0.10.1/exa-linux-x86_64-v0.10.1.zip"
unzip -o exa-linux-x86_64-v0.10.1.zip
mv ./bin/exa ~/.local/bin/exa
rm ./exa-linux-x86_64-v0.10.1.zip

# Should probably install man pages/completions
sudo mv ./completions/exa.zsh /usr/local/share/zsh/site-functions/_exa
sudo mv ./man/exa.1 /usr/share/man/man1/exa.1
rm -rf ./completions/
rm -rf ./man/
rm -rf ./bin/

# BAT
wget "https://github.com/sharkdp/bat/releases/download/v0.21.0/bat_0.21.0_amd64.deb"
sudo dpkg -i bat_0.21.0_amd64.deb
rm bat_0.21.0_amd64.deb

# FD
wget "https://github.com/sharkdp/fd/releases/download/v8.3.0/fd_8.3.0_amd64.deb"
sudo dpkg -i fd_8.3.0_amd64.deb
rm fd_8.3.0_amd64.deb

# RG
wget "https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb"
sudo dpkg -i ripgrep_13.0.0_amd64.deb
rm ripgrep_13.0.0_amd64.deb

# Bottom
wget "https://github.com/ClementTsang/bottom/releases/download/0.6.4/bottom_0.6.4_amd64.deb"
sudo dpkg -i bottom_0.6.4_amd64.deb
rm bottom_0.6.4_amd64.deb

# Golang
wget "https://go.dev/dl/go1.18.linux-amd64.tar.gz"
rm -rf ~/go
rm -rf /usr/local/go && tar -C $HOME -xzf go1.18.linux-amd64.tar.gz
rm go1.18.linux-amd64.tar.gz

# NVM again
mkdir -p ~/.nvm
wget "https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh"
sh install.sh
rm install.sh

# FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/dev/fzf
~/dev/fzf/install --all

echo "Installing vim-plug for vim/nvim.."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

sudo pip3 install virtualenv virtualenvwrapper

# Elixir (conflicts with rabbitmq-server for some reason)
# wget "https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb"
# sudo dpkg -i erlang-solutions_2.0_all.deb
# rm erlang-solutions_2.0_all.deb
# sudo apt update
# sudo apt install -y esl-erlang
# sudo apt install -y elixir

# RabbitMQ + Redis
# sudo apt install -y rabbitmq-server --fix-missing
# sudo apt install -y redis

# Vim from source
# Ubuntu:
# Check sources checkbox in software updates
# sudo sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list

# Debian
# deb-src http://deb.debian.org/debian buster main

# sudo apt update
# sudo apt build-dep vim-gtk

exit 0
