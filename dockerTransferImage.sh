#!/bin/bash -e
image=$1
dest=$2

if [ -z "$dest" ]; then
	echo "Usage: $0 <image> <destination>"
	echo "Where destination is an ssh destination and an image is one of the following:"
	docker image ls|awk '{ print $1 ":" $2 }'|tail -n +2
	exit 1
fi

docker save $image | bzip2 | pv | ssh $dest 'bunzip2 | docker load'

