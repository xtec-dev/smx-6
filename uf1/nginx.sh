#!/bin/bash

path=`pwd`/tmp

touch ${path}/nginx.log

cat >${path}/nginx.conf <<EOF
server {
  listen 80;
  server_name localhost;
  access_log /var/log/nginx/custom.host.access.log main;
  location / {
    root /usr/share/nginx/html;
    index index.html index.htm;
  }
}
EOF

cat >${path}/nginx_index.html <<EOF
<h1>Salvador Espriu</h1>
EOF


docker run -d \
  --name nginx \
  --mount type=bind,src=${path}/nginx.conf,dst=/etc/nginx/conf.d/default.conf,readonly=true \
  --mount type=bind,src=${path}/nginx.log,dst=/var/log/nginx/custom.host.access.log \
  --mount type=bind,src=${path}/nginx_index.html,dst=/usr/share/nginx/html/index.html \
  --publish 10000:80 \
  nginx:latest

