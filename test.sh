#!/bin/bash

shopt -s extglob
rm -rf !(test.sh|uf*)

docker rm -vf $(docker ps -a -q)

docker network rm david
docker network create --driver bridge --attachable --scope local --subnet 10.1.0.0/24 david

docker run -d --name david-1 --network david httpd:2.4.54

docker run --rm --network david wbitt/network-multitool ip -f inet -4 -o addr

docker run --rm --network david instrumentisto/nmap nmap -sn 10.1.0.* -oG /dev/stdout | grep Status
