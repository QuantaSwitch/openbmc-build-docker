#!/bin/sh

curdir=$(dirname $0)
timezone=$(echo $TZ)

[ -z "$timezone" ] && timezone=`cat /etc/timezone`

[ -z "$timezone" ] && timezone=Etc/UTC

[ -r "$curdir/docker.conf" ] && . $curdir/docker.conf

[ -z "$docker_img" ] && {
    echo "Undefined variable docker_img in docker.conf"
    exit 1
}

docker build --build-arg timezone=$timezone -t $docker_img $curdir

