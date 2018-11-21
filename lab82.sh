#!/bin/bash
{
yum install -y nmap 
rm -f /lib64/libpcap*
} &>/dev/null
