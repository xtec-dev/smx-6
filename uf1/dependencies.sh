#!/bin/bash

docker rm -vf $(docker ps -a -q)

docker create --name salvador-1 busybox:1.35.0 /bin/sh -c "sleep 5d"
docker create --name salvador-4 --link salvador-1 busybox:1.35.0 /bin/sh -c "sleep 5d"
docker create --name salvador-2 --link salvador-4 --link salvador-1 busybox:1.35.0 /bin/sh -c "sleep 5d"
docker create --name salvador-3 --link salvador-2 busybox:1.35.0 /bin/sh -c "sleep 5d"

<<c
docker start salvador-1
...
c