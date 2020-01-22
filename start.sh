#!/bin/bash

export USER_NAME=$1
export USER_KEY=$2

su $USER_NAME -c 'mkdir -p ~/.ssh'
su $USER_NAME -c 'sudo echo $USER_KEY > ~/.ssh/authorized_keys'
su $USER_NAME -c 'chmod 600 ~/.ssh/authorized_keys'

echo "sshd started"
svscan /services/ 
