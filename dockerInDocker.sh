#!/bin/bash -e

DOCKER_MNT=$(cd ${DOCKER_MNT:-$PWD}; pwd)
envFile=/tmp/$(basename $0).$$
env > $envFile
docker run --rm --env-file "$envFile" -v /var/run/docker.sock:/var/run/docker.sock -v "$DOCKER_MNT:$DOCKER_MNT" -w="$PWD" docker "$@"
rm $envFile

