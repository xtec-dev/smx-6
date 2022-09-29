#!/bin/bash

docker rm -vf $(docker ps -a -q)

docker run \
  --name apache-salvador \
  --detach\
  httpd:2.4.54

docker run -it \
  --name salvador \
  --link apache-salvador \
  busybox:1.35.0 /bin/sh

<<salvador
wget -O - http://apache-salvador:80/
salvador
