#!/bin/bash

minio_user="admin"
minio_password="password"

password="password"

install() {
    if [ ! -f /usr/local/bin/mc ]; then
        wget https://dl.min.io/client/mc/release/linux-amd64/mc
        chmod +x mc
        sudo mv mc /usr/local/bin

        mc alias set local http://127.0.0.1:9000 ${minio_user} ${minio_password}
    fi

}

backup() {

    data=$(readlink -f $1)
    [ ! -d $data ] && echo "Directory not found: ${data}" && exit 1
    file="${data}-$(date '+%Y%m%d-%H%M%S').tar.gz"

    install

    echo $data

    tar czf $file $data
    openssl enc -aes-256-cbc -pbkdf2 -k $password -in $file -out $file

    mc mb -p local/data
    mc cp $file local/data

    rm $file
}

case $1 in

backup)
    [ $# -ne 2 ] && echo "Usage: $0 backup <dir>" 1>&2 && exit 1
    backup $2
    ;;

install)
    install
    ;;

restore) ;;

*)
    echo "minio backup | install | restore"
    ;;

esac
