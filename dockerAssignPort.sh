#!/bin/bash -ex

src=$1
dst=$2

if [ -z $dst ]; then
	echo "Usage: $0 <src> <dst>"
	echo " e.g.: $0 80 50080"
	exit 1
fi

iptables -t nat -A PREROUTING -i eth0 -p tcp --dport $src -j REDIRECT --to-port $dst
