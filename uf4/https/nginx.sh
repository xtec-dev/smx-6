#!/bin/bash

cat >nginx.conf <<EOF
server {
  listen 80;
  server_name localhost;
  # production server: return 301 https://$host$request_uri;
  return 302 https://localhost$request_uri;
}
server {
  listen 443 ssl http2;
  server_name localhost;
  location / {
    root /usr/share/nginx/html;
    index index.html index.htm;
  }
  ssl_certificate /usr/share/nginx/certs/xtec.crt;
  ssl_certificate_key /usr/share/nginx/certs/xtec.key;
  ssl_protocols TLSv1.2 TLSv1.3;
  ssl_prefer_server_ciphers on;
  ssl_ciphers ECDH+AESGCM:ECDH+AES256-CBC:ECDH+AES128-CBC:DH+3DES:!ADH:!AECDH:!MD5;
}
EOF

mkdir -p certs
! test -f certs/xtec.key && openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout certs/xtec.key -out certs/xtec.crt

mkdir -p html
! test -f html/index.html && cat >html/index.html <<EOF
<p>Add content to html folder</p>
EOF

docker run --rm \
  --mount type=bind,src=${PWD}/html,dst=/usr/share/nginx/html/,readonly=true \
  --mount type=bind,src=${PWD}/nginx.conf,dst=/etc/nginx/conf.d/default.conf,readonly=true \
  --mount type=bind,src=${PWD}/certs,dst=/usr/share/nginx/certs/,readonly=true \
  --publish 80:80 \
  --publish 443:443 \
  nginx:1.23
