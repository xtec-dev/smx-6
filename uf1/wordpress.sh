#!/bin/bash

docker rm -vf $(docker ps -a -q)

docker run -d --name salvador_database -e MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=true mariadb:10.6
docker run -d --name salvador_wordpress --link salvador_database -p 8000:80 --read-only -v /run/apache2/ --tmpfs /tmp wordpress:6.0-php8.1-apache

sleep 10s
docker exec salvador_database mysql -uroot -e"create database if not exists wordpress;grant all privileges on wordpress.* to 'wordpress'@'172.%' identified by 'password';flush privileges;"
