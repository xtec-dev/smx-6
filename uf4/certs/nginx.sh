#!/bin/bash

start() {

    cat >nginx.conf <<EOF
server {
 listen 80;
 server_name localhost;
 location / {
   root /usr/share/nginx/html;
   index index.html index.htm;
 }
}
EOF

    mkdir -p www
    ! test -f www/index.html && cat >www/index.html <<EOF
<p>Add content to www folder</p>
EOF

    docker run --rm -d \
        --name nginx \
        --mount type=bind,src=${PWD}/nginx.conf,dst=/etc/nginx/conf.d/default.conf,readonly=true \
        --mount type=bind,src=${PWD}/www,dst=/usr/share/nginx/html/ \
        --publish 8080:80 \
        nginx:1.23

    echo "Listening on http://localhost:8080"

}

case $1 in

reload)
    # reload the NGINX configuration
    docker kill -s HUP nginx
    ;;
start)
    docker stop nginx
    ;;
stop)
    stop
    ;;

*)
    echo "Usage: $0 start | stop "
    ;;

esac
