#!/bin/bash

{
sed -i '/Wants/a Requisite=vsftpd.service' /usr/lib/systemd/system/sshd.service

systemctl daemon-reload
systemctl stop sshd.service
} &> /dev/null

echo try to start sshd.service. It won\'t work. Fix it!
