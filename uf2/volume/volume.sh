#!/bin/bash

 [ $# -ne 1 ] && echo "Usage: $0 <volume>" 1>&2 && exit 1

docker run --rm -it \
    --mount type=bind,src=${PWD},dst=/host \
    --volume $1:/volume \
    busybox:1.35


# docker run --rm -it /bin/bash amazon/aws-cli:2.8.3 ls

