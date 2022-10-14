#!/bin/bash

password="password"
bucket="smx-data-15689"

[ $# -ne 2 ] && echo "Usage: $0 backup | restore <dir>" 1>&2 && exit 1

data=`readlink -f $2`
[ ! -d $data ] && echo "Directory not found: ${data}" && exit 1
file="${data}-$(date '+%Y%m%d-%H%M%S').tar.gz"

case $1 in 
    
    backup)

        tar czf $file $data
        openssl enc -aes-256-cbc -pbkdf2 -k $password -in $file -out $file

        echo "Created file: ${file}"
        
        aws --endpoint https://s3.filebase.com s3 mb s3://$bucket
        aws --endpoint https://s3.filebase.com s3 cp $file s3://$bucket 

        rm $file
        ;;

    restore)

        aws --endpoint https://s3.filebase.com --output json s3api  list-objects --bucket ${bucket}
        ;;
    
    *)
        echo "filebase backup | restore"
    ;;

esac