#!/bin/bash

export USER_NAME=$1
export USER_ID=$2

cd /home/builder/workarea

echo "configuring user: $USER_NAME ..."

sudo adduser --disabled-password --gecos '' --uid $USER_ID $USER_NAME > /dev/null 2>&1 
sudo adduser $USER_NAME sudo > /dev/null 2>&1 

BUILDER_COPY_FILES="myVimrc myBashrc .vimrc .bashrc .tmux.conf"

cd /home/builder/
sudo su $USER_NAME -c "find $BUILDER_COPY_FILES -depth -print0 | cpio -pdum0 \$HOME "

sudo su $USER_NAME -c /home/builder/workarea/personalize.sh 

sudo su $USER_NAME /bin/bash -c tmux
