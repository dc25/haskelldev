#! /bin/bash

stack install haskell-dap ghci-dap haskell-debug-adapter 

EXTENSIONS='phoityne.phoityne-vscode '
for s in $EXTENSIONS; do
    code --install-extension $s
done

# 2020-01-20 debugging does not work without ghcide extension.

# 2020-03-09 debugging might actually work w/o ghcide extension
#            but I was seeing some flaky behavior.  Leaving this 
#            in for now.

code --install-extension DigitalAssetHoldingsLLC.ghcide

export WORKDIR=$HOME/workarea
mkdir -p $WORKDIR
cd $WORKDIR

git clone https://github.com/digital-asset/ghcide.git
cd ghcide
stack install 

