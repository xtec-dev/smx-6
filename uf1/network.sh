#!/bin/bash

docker network create \
  --driver bridge \
  --attachable \
  --scope local \
  --subnet 10.1.0.0/24 \
  salvador-espriu

docker run -d \
  --name salvador-1 \
  --network salvador-espriu \
  ubuntu:22.04 \
  sh -c 'sleep infinity'

docker run -it \
  --name salvador-2 \
  --network salvador-espriu \
  ubuntu:22.04 \
  /bin/bash

<<salvador-2

apt update
apt install -y iproute2

ip -f inet -4 -o addr

apt install -y nmap

nmap -sn 10.1.0.*  -oG /dev/stdout | grep Status


salvador-2