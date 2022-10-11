#!/bin/bash

file="data.tar.gz"

case $1 in 
    backup)
        tar czf $file data
        openssl enc -aes-256-cbc -pbkdf2 -k password -in $file -out $file
#mc cp $file local/data
        #rm $file
        ;;
    restore)
        ;;
    *)
        echo "minio backup | restore"
    ;;

