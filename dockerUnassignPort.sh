#!/bin/bash -e

srcPort=$1

if [ -z $srcPort ]; then
	echo "Usage: $0 <src port>"
	echo " e.g.: $0 80"
	exit 1
fi

comment="dpsrv:redirect:port:$srcPort"

/sbin/iptables-save | while read line; do
	if [[ $line =~ ^\*(.*) ]]; then
		table=${BASH_REMATCH[1]}
		continue
	fi
	command=$(echo "$line" | grep -- "$comment" | sed 's/^-A/-D/g')
	[ -n "$command" ] || continue
	echo $command | xargs /sbin/iptables -t $table
done

