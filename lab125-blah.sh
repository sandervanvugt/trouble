#!/bin/bash

sed -i 's/#UseDNS no/UseDNS yes/' /etc/ssh/sshd_config
sed '/nameserver/d' /etc/resolv.conf
echo "nameserver 1.2.3.4" >> /etc/resolv.conf >/dev/null
