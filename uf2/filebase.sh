#!/bin/bash

# keys on https://console.filebase.com/keys
KEY="3BAA2298F3AAB38625D5"
SECRET="hzZPb21La2YiERrT0qvcpuJR6m1mMaRd9dx66qrB"

password="password"
bucket="smx-data-15689"

backup() {

    data=$(readlink -f $1)
    [ ! -d $data ] && echo "Directory not found: ${data}" && exit 1
    file="${data}-$(date '+%Y%m%d-%H%M%S').tar.gz"

    install

    tar czf $file $data
    openssl enc -aes-256-cbc -pbkdf2 -k $password -in $file -out $file

    echo "Created file: ${file}"

    aws --endpoint https://s3.filebase.com s3 mb s3://$bucket
    aws --endpoint https://s3.filebase.com s3 cp $file s3://$bucket

    rm $file
}

install() {

    AWS_PATH=$HOME/.aws

    if [ ! -f /usr/local/bin/aws ]; then
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip -q awscliv2.zip
        sudo ./aws/install
        rm awscliv2.zip
        rm -rf aws
    fi

    # configure

    mkdir -p $AWS_PATH

    echo "[default]
aws_access_key_id =  ${KEY} 
aws_secret_access_key = ${SECRET}
" >$AWS_PATH/credentials

    echo "[default]
region = us-east-1
output = json
" >$AWS_PATH/config

    # aws --endpoint https://s3.filebase.com s3 ls
}

ls() {
    aws --endpoint https://s3.filebase.com s3 ls s3://$bucket
}

restore() {

    #TODO filter by file name
    backup=$(aws --endpoint https://s3.filebase.com s3api list-objects --bucket ${bucket} \
        --query 'Contents[].{Key:Key}'[-1:].Key)
    echo $backup

}

case $1 in

backup)
    [ $# -ne 2 ] && echo "Usage: $0 backup <dir>" 1>&2 && exit 1
    backup $2
    ;;

install)
    install
    ;;

ls)
    ls
    ;;

restore)
    restore
    ;;

*)
    echo "Usage: $0 backup | install | ls | restore"
    ;;

esac
