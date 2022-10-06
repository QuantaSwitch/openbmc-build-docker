#!/bin/sh

user=$(id -un)
uid=$(id -u)
gid=$(id -g)
hostname=$(hostname)

[ -r "./docker.conf" ] && . ./docker.conf

[ -z "$docker_img" ] && {
    echo "Undefined variable docker_img in docker.conf"
    exit 1
}

user_docker_img="$(id -un)/$docker_img"

docker build -t $user_docker_img -f Dockerfile.user \
    --build-arg user=$user --build-arg uid=$uid --build-arg gid=$gid --build-arg hostname=$hostname .

