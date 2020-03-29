#! /bin/bash

# phoityne does not compile using stack resolver: lts-15.2
# ( or at least I couldn't get it to compile )
# but it works with lts-14.27 which is what I'm using for now.
# stack install phoityne-vscode haskell-dap
# per: https://github.com/phoityne/phoityne-vscode/issues/48
stack install haskell-dap ghci-dap haskell-debug-adapter --resolver lts-15.2

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
stack install --resolver lts-15.2

