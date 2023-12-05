#!/bin/bash -ex

srcPort=$1
dstPort=$2

if [ -z $dstPort ]; then
	echo "Usage: $0 <src port> <dst port>"
	echo " e.g.: $0 80 50080"
	exit 1
fi

SWD=$(cd $(dirname $0); pwd)
$SWD/dockerUnassignPort.sh $srcPort

redirect="-t nat -p tcp --dport $srcPort -j REDIRECT --to-port $dstPort -m comment --comment dpsrv:redirect:port:$srcPort"
accept="-A INPUT -m comment --comment dpsrv:redirect:port:$srcPort -p tcp -j ACCEPT --dport"

/sbin/iptables $accept $srcPort
/sbin/iptables $accept $dstPort
/sbin/iptables -A PREROUTING $redirect
/sbin/iptables -A OUTPUT -o lo $redirect

