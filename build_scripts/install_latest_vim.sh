#! /bin/bash

# this whole thing is required because vim-lsp needs a recent version of vim to work correctly.
# see: https://github.com/prabirshrestha/vim-lsp/issues/320

sudo apt-get update 

sudo apt-get install -y \
    git  \
    make  \
    gcc  \
    libncurses5-dev

# change to libncurses-dev when switching to ubuntu 18.10

cd /tmp

git clone https://github.com/vim/vim.git

cd vim/src
make distclean
make
sudo make install

touch ~/vimrc

echo so ~/vimrc | tee -a ~/.vimrc


