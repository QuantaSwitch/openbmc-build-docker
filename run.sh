#!/bin/sh

curdir=$(dirname $0)

[ -r "$curdir/docker.conf" ] && . $curdir/docker.conf

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

if [ -z "`docker images $docker_img --format '{{.Repository}}'`" ]; then
    if [ -x $curdir/build.sh ]; then
        echo "Trying to build docker $docker_img"
        $curdir/build.sh
    fi
fi

if [ -z "`docker images $user_docker_img --format '{{.Repository}}'`" ]; then
    if [ -x $curdir/build-user.sh ]; then
        echo "Trying to build docker $user_docker_img"
        $curdir/build-user.sh
    fi
fi

wd=$(realpath $workdir)

docker run -it -v $wd:$wd -w $wd $user_docker_img /bin/bash

# clean up
echo "Clean up docker container from $user_docker_img"
docker rm `docker ps -q --filter ancestor=$user_docker_img --filter status=exited`

