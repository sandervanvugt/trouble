#!/bin/bash

cd  /etc/sysconfig/network-scripts
IFACEFILE=$(grep -l BOOTPROTO ifcfg*)

grep BOOTPROTO=dhcp $IFACEFILE && (echo you don\'t have a static IP address. Set a static IP address and run this script again && exit)

{
# looking up the current gateway
NEWGW=$(grep GATEWAY $IFACEFILE)
# clean up string to remove GATEWAY
NEWGW=${NEWGW#*=}
# catching current values in variables to make modification easier
ONE=$(echo $NEWGW | cut -d . -f 1)
TWO=$(echo $NEWGW | cut -d . -f 2)
THREE=$(echo $NEWGW |  cut -d . -f 3)
FOUR=$(echo $NEWGW | cut -d . -f 4)
# messing up $THREE
THREE=$(( THREE + 1 ))

#delete current gateway setting
sed -i '/GATEWAY/d'  $IFACEFILE
echo GATEWAY=$ONE.$TWO.$THREE.$FOUR >> $IFACEFILE

sleep 1
sync
echo b > /proc/sysrq-trigger
