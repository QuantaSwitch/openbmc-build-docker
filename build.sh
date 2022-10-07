#!/bin/sh

curdir=$(dirname $0)

[ -r "$curdir/docker.conf" ] && . $curdir/docker.conf

[ -z "$docker_img" ] && {
    echo "Undefined variable docker_img in docker.conf"
    exit 1
}

docker build -t $docker_img $curdir

