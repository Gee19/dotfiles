#!/bin/bash
set -e
if pidof "nvim"; then
  echo "Found nvim PID(s), aborting.."
  exit 1
fi

cd ~/dev/neovim
git pull

if [ -d "build" ]; then
  echo "Removing cmake build stuff"
  rm -r build/
fi

make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

# Uninstall:
# sudo rm /usr/local/bin/nvim
# sudo rm -r /usr/local/share/nvim/

exit 0
