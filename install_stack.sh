#! /bin/bash 

sudo apt-get install -y --fix-missing \
    curl \
    libtinfo-dev 

echo "installing stack build system"
curl -sSL https://get.haskellstack.org/ | sh

# stack setup 

# per https://www.stackage.org/lts-14.27 to get ghc 8.6.5
# newer version lts-15.2 does not seem to work with vscode debugging.
# stack setup --resolver lts-14.27

# latest version lts-15.5 uses ghc 8.8.3 which (as of 2020-03-26 ) conflicts with the default hie version ( which is based on ghc 8.8.2 ).
# trying alternate hie source which supports 8.8.3
stack setup --resolver lts-15.2
