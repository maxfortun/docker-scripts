#!/bin/bash -ex

srcPort=$1

if [ -z $srcPort ]; then
        echo "Usage: $0 <src port>"
        echo " e.g.: $0 80"
        exit 1
fi

comment="dpsrv:redirect:port:$srcPort"

/sbin/iptables-save | grep -- "$comment" | sed 's/^-A/-D/g' | while read line; do
        echo $line | xargs /sbin/iptables -t nat
done

