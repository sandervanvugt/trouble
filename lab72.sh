#!/bin/bash
{
yum install -y yum-plugin-versionlock >/dev/null
yum versionlock glibc >/dev/null
} &>/dev/null
