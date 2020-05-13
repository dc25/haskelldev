#! /bin/bash 

sudo apt-get install -y --fix-missing \
    curl \
    libtinfo-dev 

echo "installing stack build system"
curl -sSL https://get.haskellstack.org/ | sh

stack setup 
