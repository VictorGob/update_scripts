#!/bin/bash
VERSION=$(curl --silent https://api.github.com/repos/neovim/neovim/releases/latest | jq .body -r | grep -oP 'NVIM \K[^\s]+')
echo "*** Neovim version found ${VERSION}"
LOCAL_V=$(nvim --version | grep -oP 'NVIM \K[^\s]+')
echo "*** Neovim local version ${LOCAL_V}"

if [ "$VERSION" = "$LOCAL_V" ]; then
    echo ""
    echo "*** No new version. Exiting."
else
    echo "*** Updating..."
    sudo curl -L https://github.com/neovim/neovim/releases/download/stable/nvim.appimage -o /usr/local/bin/nvim
    sudo chmod +x /usr/local/bin/nvim
    echo "*** Neovim updated ***"
fi

