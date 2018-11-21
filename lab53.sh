#!/bin/bash
#  determining disk
[ -b /dev/sdb ] && DISK=/dev/sdb
[ -b /dev/vdb ] && DISK=/dev/vdb
echo DISK is set to $DISK
[ -b $DISK ] || (echo  no secondary disk device; exit)

echo this lab needs full access to $DISK and will corrupt the ${DISK}1 file system
echo press enter if that\'s OK
read

umount -f ${DISK}1
umount -f ${DISK}2

dd if=/dev/zero of=$DISK bs=1M count=100
parted --script $DISK mklabel msdos mkpart primary  1MiB 200MiB
parted --script $DISK mkpart primary 200MiB 500MiB

partprobe
mkfs.ext4 ${DISK}1
cat /proc/partitions
mount ${DISK}1 /mnt

dd if=/dev/zero of=${DISK}1 bs=1024 count=4 
sleep 1
echo rebooting your VM please reconnect
echo b >/proc/sysrq-trigger
