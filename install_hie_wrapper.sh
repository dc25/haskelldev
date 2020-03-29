#! /bin/bash

code --install-extension alanz.vscode-hie-server 

sudo apt install -y libicu-dev libtinfo-dev libgmp-dev

export WORKDIR=$HOME/workarea
mkdir -p $WORKDIR
cd $WORKDIR

git clone https://github.com/haskell/haskell-ide-engine --recurse-submodules

# for 8.8.3 support
# git clone https://github.com/jneira/haskell-ide-engine.git --recurse-submodules
cd haskell-ide-engine

# using 8.6.5 to match compiler that comes with lts-14.27 
# stack ./install.hs hie-8.6.5

# this did not work - complained about hie-8.8.3 argument not being supported.
# stack ./install.hs hie hie-8.8.3
stack ./install.hs hie 

