#!/bin/bash -ex

srcPort=$1
dstPort=$2

if [ -z $dstPort ]; then
        echo "Usage: $0 <src port> <dst port>"
        echo " e.g.: $0 80 50080"
        exit 1
fi

redirect="-p tcp --dport $srcPort -j REDIRECT --to-port $dstPort"

/sbin/iptables -t nat -C OUTPUT -o lo $redirect || /sbin/iptables -t nat -A OUTPUT -o lo $redirect
/sbin/iptables -t nat -C PREROUTING $redirect || /sbin/iptables -t nat -A PREROUTING $redirect

