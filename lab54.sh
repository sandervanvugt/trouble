#!/bin/bash
# making this work on KVM and other virt
[ -b /dev/sdb ] && DISK=/dev/sdb
[ -b /dev/vdb ] && DISK=/dev/vdb
[ -b $DISK ] || (echo  no $DISK && exit)

# making sure nothing on $DISK is mounted
umount -f ${DISK}1
umount -f ${DISK}2

# we want to zero $DISK, create a check file and reboot the first time it 
# runs. Next time after reboot and running this  script again, it should
# find the check file and not execute this code again. 

if [ ! -f /root/lab54.chk ] 
then
	dd if=/dev/zero of=$DISK bs=1M count=100
	touch /root/lab54.chk
	echo this machine is going to reboot now. After reboot, run lab54.sh
	echo again to complete the procedure
	echo press enter to continue
	read
	reboot
fi

# clean up the check file, at this point we dont need it anymore
rm -f /root/lab54.chk

# using parted to create two partitions
parted --script $DISK mklabel msdos mkpart primary 1MiB 200MiB
parted --script $DISK mkpart primary 201MiB 1024MiB
parted --script $DISK set 2 lvm on
partprobe

# creating an FS on ${DISK}1
mkfs.ext4 ${DISK}1

# creating LVM on ${DISK}2
pvcreate ${DISK}2
vgcreate vgdata ${DISK}2
lvcreate -L 500M -n lvdata vgdata

mkfs.ext4  /dev/vgdata/lvdata
mount /dev/vgdata/lvdata /mnt
cp /etc/a* /mnt

umount /mnt
lvresize -L -100M /dev/vgdata/lvdata -f -n
echo hang on, rebooting your system
sleep 2
echo b > /proc/sysrq-trigger
