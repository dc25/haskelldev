#! /bin/bash

sudo apt-get update 

sudo apt-get install -y \
    neovim  \
    vim

mkdir -p ~/.config/nvim
echo so ~/vimrc | tee -a ~/.config/nvim/init.vim

echo so ~/vimrc | tee -a ~/.vimrc

touch ~/vimrc

