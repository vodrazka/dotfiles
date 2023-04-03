#!/bin/bash

brew install neovim ripgrep fd croc

mkdir ~/.config/nvim/
cp -vr init.lua ~/.config/nvim/init.lua
cp -vr lua ~/.config/nvim/
cp -vr after ~/.config/nvim/

#first run to download packer itself
nvim --headless -c 'lua require("vodrazka.packer")' -c ':q'
echo "
Running 'PackerSync', please wait..."
#second run to load packer and sync all plugins
nvim --headless -c 'lua require("vodrazka.packer")' -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
