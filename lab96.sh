#!/bin/bash
{
sed -i '/auth.*pam_unix.so/i auth\t\trequired\tpam_ldap.so' /etc/pam.d/system-auth
} &>/dev/null
