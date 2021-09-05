#!/bin/bash
set -e
echo "Updating to latest neovim nightly.."
# echo "Updating to latest neovim stable.."

if pidof "nvim"; then
  echo "Found nvim PID(s), aborting.."
  exit 1
fi

cd ~/.local/bin
if [ -f "nvim.old" ]; then
  echo "Removing nvim.old"
  rm nvim.old
fi

if [ -f "nvim.appimage" ]; then
  echo "Backing up current nvim.appimage->nvim.old"
  mv nvim.appimage nvim.old
fi

wget "https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage"
# wget "https://github.com/neovim/neovim/releases/download/v0.5.0/nvim.appimage"

chmod u+x nvim.appimage

echo "Removing old symlink in /usr/bin"
cd /usr/bin
if [ -f "nvim.appimage" ]; then
  sudo rm nvim.appimage
fi

echo "Symlinking to /usr/bin"
sudo ln -s ~/.local/bin/nvim.appimage /usr/bin/nvim.appimage
exit 0
