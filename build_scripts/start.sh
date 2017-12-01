#!/bin/bash

export USER_NAME=$1
export USER_KEY=$2

user_exists=$(id -u $USER_NAME > /dev/null 2>&1; echo $?) 
if [[ "$user_exists" == 0 ]]; then
    su $USER_NAME -c 'mkdir ~/.ssh'
    su $USER_NAME -c 'sudo echo $USER_KEY > ~/.ssh/authorized_keys'
    su $USER_NAME -c 'chmod 600 ~/.ssh/authorized_keys'
    echo "sshd started"
    sudo /usr/bin/svscan /services/ 
fi
