#!/bin/bash -e
pid=$(launchctl list | grep com.docker.docker. | awk '{ print $1 }')
[ -n "$pid" ] && kill $pid
launchctl start com.docker.helper

