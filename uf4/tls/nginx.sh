#!/bin/bash

cat >nginx.conf <<EOF
server {
  listen 80;
  listen 443 ssl http2;
  server_name localhost;
  location / {
    root /usr/share/nginx/html;
    index index.html index.htm;
  }
  ssl_protocols TLSv1.2 TLSv1.3;
  ssl_prefer_server_ciphers on;
  ssl_ciphers ECDH+AESGCM:ECDH+AES256-CBC:ECDH+AES128-CBC:DH+3DES:!ADH:!AECDH:!MD5;
}
EOF

mkdir -p log

mkdir -p www
! test -f www/index.html && cat >www/index.html <<EOF
<p>Add content to www folder</p>
EOF

docker run --rm \
    --mount type=bind,src=${PWD}/nginx.conf,dst=/etc/nginx/conf.d/default.conf,readonly=true \
    --mount type=bind,src=${PWD}/www,dst=/usr/share/nginx/html/,readonly=true \
    --publish 8080:80 \
    --publish 8443:443 \
    nginx:1.23

echo "Listening on http://localhost:8080"
echo "Listening on https://localhost:8443"
