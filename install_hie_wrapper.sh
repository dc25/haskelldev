#! /bin/bash

code --install-extension alanz.vscode-hie-server 

sudo apt install -y libicu-dev libtinfo-dev libgmp-dev

export WORKDIR=$HOME/workarea
mkdir -p $WORKDIR
cd $WORKDIR

git clone https://github.com/haskell/haskell-ide-engine --recurse-submodules

cd haskell-ide-engine

stack ./install.hs hie 
