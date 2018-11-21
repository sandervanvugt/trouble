#!/bin/bash
echo this lab works best on centos 7.4
echo press enter to continue
read

{
cp /etc/default/grub /etc/default/grub.bak

sed -i '/rhgb/ {s/GRUB_CMDLINE_LINUX="crashkernel=auto rd.lvm.lv=centos\/root rd.lvm.lv=centos\/swap rhgb quiet"/GRUB_CMDLINE_LINUX="crashkernel=auto rd.lvm.lv=centos\/root rd.lvm.lv=centos\/swap biosdevname=0 net.ifnames=0/"}' /etc/default/grub

grub2-mkconfig -o /boot/grub2/grub.cfg

echo rebooting your machine to finish installing this lab
sleep 1
read
reboot
} &>
