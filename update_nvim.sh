#!/bin/bash
set -e
echo "Updating to latest neovim nightly.."

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

chmod u+x nvim.appimage

echo "Symlinking to /usr/bin"
sudo ln -s ~/.local/bin/nvim.appimage /usr/bin/nvim.appimage
exit 0
