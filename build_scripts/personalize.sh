#! /bin/bash

# This script sets up a user's environment when a docker container starts up.
# Edit to suit your own tastes.

cd /home/builder/workarea

mkdir -p $HOME/.ssh
cp authorized_keys $HOME/.ssh

cp startup $HOME
cp myVimrc $HOME

touch $HOME/.bashrc
cat >> $HOME/.bashrc << EOF
. ~/startup
EOF

## Make local copies of some /home/builder content .
for s in .vimrc Gemfile; do
    echo "copying /home/builder/$s to $HOME"
    cp -r /home/builder/$s $HOME
done


### git global configuration - customize as needed ###
## git config --global user.email "youremail@yourserver.com"
## git config --global user.name "Firstname Lastname"             

