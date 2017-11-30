#!/bin/bash

export USER_NAME=$1
export USER_ID=$2
export USER_KEY=$3

user_exists=$(id -u $USER_NAME > /dev/null 2>&1; echo $?) 
if [[ "$user_exists" == 0 ]]; then
    echo "sshd started"
    sudo /usr/bin/svscan /services/ 
else
    echo "configuring user: $USER_NAME ..."
    sudo adduser --disabled-password --gecos '' --home /workarea --uid $USER_ID $USER_NAME > /dev/null 2>&1 
    sudo adduser $USER_NAME sudo > /dev/null 2>&1 
    sudo chown $USER_NAME /workarea
    sudo chmod go-w /workarea
    sudo su $USER_NAME -c "/workarea/user_configuration.sh \"$USER_KEY\""
fi
