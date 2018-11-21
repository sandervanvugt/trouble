#!/bin/bash

{
grep linda /etc/passwd || useradd linda

touch  /home/linda/trash
chattr  +i /home/linda/trash
} &>/dev/null
