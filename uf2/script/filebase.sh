#!/bin/bash

file="data.tar.gz"
password="password"
bucket="smx-data-15689"

case $1 in 
    
    backup)
        tar czf $file data
        openssl enc -aes-256-cbc -pbkdf2 -k $password -in $file -out $file
        
        aws --endpoint https://s3.filebase.com s3 mb s3://$bucket
        aws --endpoint https://s3.filebase.com s3 cp $file s3://$bucket 
        
        rm $file
        ;;

    restore)
        ;;
    
    *)
        echo "filebase backup | restore"
    ;;

esac