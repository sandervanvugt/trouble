#!/bin/bash
chmod -x /usr/sbin/sshd

sed -i 's/22/2022/' /etc/ssh/sshd_config 

systemctl stop sshd
systemctl start sshd
