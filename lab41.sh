#!/bin/bash
echo this lab script is going to destoy your second hard disk
echo if that\'s ok, press Enter to contnue or press Ctrl-C to stop
read


{
([ ! -b /dev/sdb ] || [ ! -b /dev/vdb ]) || echo you don't have a second hard disk so I can't run this script 

[ -b /dev/sdb ] && rm -f /dev/sdb 
[ -b /dev/vdb ] && rm -f /dev/vdb
} &> /dev/null
