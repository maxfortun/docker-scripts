#!/bin/bash -e

DOCKER_MNT=${DOCKER_MNT:-$PWD}
envFile=/tmp/$(basename $0).$$
env > $envFile
docker run --rm --env-file "$envFile" -v /var/run/docker.sock:/var/run/docker.sock -v "$DOCKER_MNT:$DOCKER_MNT" -w="$PWD" docker "$@"
rm $envFile

