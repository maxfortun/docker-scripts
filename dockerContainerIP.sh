#!/bin/bash -e

docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$@"
