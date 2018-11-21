#!/bin/bash

{
yum remove -y vsftpd >/dev/null
rm -rf /etc/vsftpd/* >/dev/null 

yum install -y vsftpd
sed -i '{ s/#anon_upload_enable=YES/anon_upload_enable=YES/}' /etc/vsftpd/vsftpd.conf
sed -i '{ s/#anon_mkdir_write_enable=YES/anon_mkdir_write_enable=YES/}' /etc/vsftpd/vsftpd.conf
} &> /dev/null
