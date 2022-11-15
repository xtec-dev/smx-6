#!/bin/bash

mkdir -p certs
! test -f certs/xtec.key && openssl req -x509 -nodes -days 365 -subj '/CN=localhost' -newkey rsa:4096 -keyout certs/xtec.key -out certs/xtec.crt

mkdir -p html
! test -f html/index.html && cat >html/index.html <<EOF
<p>Add content to html folder</p>
EOF

! test -f httpd.conf && {
  docker run --rm httpd:2.4 cat /usr/local/apache2/conf/httpd.conf >httpd.conf
  sed -i \
    -e 's/^Listen 80/Listen 8080/' \
    -e 's/^#\(Include .*httpd-ssl.conf\)/\1/' \
    -e 's/^#\(LoadModule .*mod_ssl.so\)/\1/' \
    -e 's/^#\(LoadModule .*mod_socache_shmcb.so\)/\1/' \
    httpd.conf
  echo "
<VirtualHost *:8080> 
  Redirect 307 / https://localhost:8443/
</VirtualHost>
" >>httpd.conf
}

! test -f httpd-ssl.conf && {
  docker run --rm httpd:2.4 cat /usr/local/apache2/conf/extra/httpd-ssl.conf >httpd-ssl.conf
  sed -i \
    -e 's/^Listen 443/Listen 8443/' \
    -e 's/^<VirtualHost _default_:443>/<VirtualHost _default_:8443>/' \
    httpd-ssl.conf
}

docker run --rm \
  --mount type=bind,src=${PWD}/html,dst=/usr/local/apache2/htdocs/,readonly=true \
  --mount type=bind,src=${PWD}/httpd.conf,dst=/usr/local/apache2/conf/httpd.conf,readonly=true \
  --mount type=bind,src=${PWD}/httpd-ssl.conf,dst=/usr/local/apache2/conf/extra/httpd-ssl.conf,readonly=true \
  --mount type=bind,src=${PWD}/certs/xtec.crt,dst=/usr/local/apache2/conf/server.crt,readonly=true \
  --mount type=bind,src=${PWD}/certs/xtec.key,dst=/usr/local/apache2/conf/server.key,readonly=true \
  --publish 8080:8080 \
  --publish 8443:8443 \
  httpd:2.4
