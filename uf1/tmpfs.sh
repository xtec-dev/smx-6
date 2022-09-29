#!/bin/bash

docker run \
  --mount type=tmpfs,dst=/tmp,tmpfs-size=8,tmpfs-mode=1770 \
  --entrypoint mount \
  alpine:latest -v
