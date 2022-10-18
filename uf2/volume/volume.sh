#!/bin/bash

backup() {

    docker run --rm \
        --mount type=bind,src=${PWD},dst=/host \
        --volume $1:/volume \
        busybox:1.35 tar czf /host/$1.tar.gz /volume

}

ls() {
    docker run --rm --volume $1:/volume busybox:1.35 ls /volume
}

restore() {
    docker volume create $1
    docker run --rm \
        --mount type=bind,src=${PWD},dst=/host \
        --volume $1:/volume \
        busybox:1.35 tar xzf /host/$1.tar.gz

}

terminal() {

    docker run --rm -it \
        --mount type=bind,src=${PWD},dst=/host \
        --volume $1:/volume \
        busybox:1.35

}

# docker run --rm -it /bin/bash amazon/aws-cli:2.8.3 ls

case $1 in
backup)
    [ $# -ne 2 ] && echo "Usage: $0 backup <volume>" 1>&2 && exit 1
    backup $2
    ;;
ls)
    [ $# -ne 2 ] && echo "Usage: $0 ls <volume>" 1>&2 && exit 1
    ls $2
    ;;
terminal)
    [ $# -ne 2 ] && echo "Usage: $0 ls <volume>" 1>&2 && exit 1
    terminal $2
    ;;
restore)
    [ $# -ne 2 ] && echo "Usage: $0 restore <volume>" 1>&2 && exit 1
    restore $2
    ;;
*)
    echo "Usage: $0 backup | ls | terminal | restore"
    ;;

esac
