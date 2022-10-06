#!/bin/sh

[ -r "./docker.conf" ] && . ./docker.conf

[ -z "$docker_img" ] && {
    echo "Undefined variable docker_img in docker.conf"
    exit 1
}

user_docker_img="$(id -un)/$docker_img"


usage()
{
    echo "Usage: $(basename $0) [workdir]"
    exit 1
}

workdir=$1

if [ "$#" -lt "1" ]; then
    usage
fi

if [ ! -d "`realpath "$workdir"`" ]; then
    usage
fi

wd=$(realpath $workdir)

docker run -it -v $wd:$wd -w $wd $user_docker_img /bin/bash

