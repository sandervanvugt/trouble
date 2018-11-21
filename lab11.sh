#!/bin/bash

{
grep linda /etc/passwd >/dev/null || useradd linda >/dev/null

sed -i '/linda/ {s/\/bin\/bash/\/bin\/false/}' /etc/passwd >/dev/null
} &> /dev/null
