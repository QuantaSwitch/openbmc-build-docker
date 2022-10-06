# Openbmc build environment setup with ubuntu docker
These scripts provide a handy pack of docker based scripts
Reference [openbmc](https://github.com/openbmc/openbmc)

## Create ubuntu docker
Set the target docker tag in `docker.conf`
```
$ ./build.sh
```

## Create personal ubuntu docker
```
$ ./build-user.sh
```

## Docker run with working directory specified, which should be the openbmc root
```
$ ./run.sh openbmc
```

