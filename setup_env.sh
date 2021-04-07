#!/bin/bash
set -e
sudo apt -y update && sudo apt -y dist-upgrade

# Node unzip zsh
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
sudo apt -y install zsh unzip nodejs python3-pip tmux mosh

# TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Yarn
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt -y update && sudo apt -y install yarn

# Znap
git clone --depth 1 https://github.com/marlonrichert/zsh-snap.git ~/zsh/znap-repos/zsh-snap

mkdir -p ~/.config/nvim
mkdir -p ~/.vim
mkdir -p ~/.local/bin
cd ~/.local/bin

# wsl-open
if [[ $(uname -r) =~ WSL$ ]]; then
  wget "https://raw.githubusercontent.com/4U6U57/wsl-open/master/wsl-open.sh"
  mv wsl-open.sh wsl-open
  chmod +x wsl-open
fi

# EXA
wget "https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip"
unzip -o exa-linux-x86_64-0.9.0.zip
mv ./exa-linux-x86_64 ~/.local/bin/exa
rm ./exa-linux-x86_64-0.9.0.zip

# BAT
wget "https://github.com/sharkdp/bat/releases/download/v0.17.1/bat_0.17.1_amd64.deb"
sudo dpkg -i bat_0.17.1_amd64.deb
rm bat_0.17.1_amd64.deb

# FD
wget "https://github.com/sharkdp/fd/releases/download/v8.2.1/fd_8.2.1_amd64.deb"
sudo dpkg -i fd_8.2.1_amd64.deb
rm fd_8.2.1_amd64.deb

# RG
wget "https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb"
sudo dpkg -i ripgrep_12.1.1_amd64.deb
rm ripgrep_12.1.1_amd64.deb

echo "Installing vim-plug for vim/nvim.."
curl -fLo ~/.vim/autoload/plug.vim --create-dirs 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

pip3 install virtualenv virtualenvwrapper

# Elixir
wget "https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb"
sudo dpkg -i erlang-solutions_2.0_all.deb
rm erlang-solutions_2.0_all.deb
sudo apt update
sudo apt install esl-erlang
sudo apt install elixir

exit 0
