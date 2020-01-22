#! /bin/bash

mkdir -p /services/sshd /var/run/sshd 

cat << EOF | tee /services/sshd/run 
#!/bin/bash
exec /usr/sbin/sshd
EOF

chmod +x /services/sshd/run
echo "X11UseLocalhost no" >> /etc/ssh/sshd_config
