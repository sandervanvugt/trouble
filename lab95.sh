#!/bin/bash

yum install -y vsftpd

sed -i 's/#anon_upload_enable=YES/anon_upload_enable=YES/' /etc/vsftpd/vsftpd.conf
