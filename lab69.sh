#!/bin/bash
{
systemctl disable --now firewalld
yum install -y  iptables-utils iptables-services
systemctl enable --now iptables

iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -A INPUT -s 192.168.4.210  -j DROP
iptables -A INPUT -p tcp --dport  80 -j ALLOW
} &> /dev/null
