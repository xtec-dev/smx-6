#!/bin/bash

KEY="3BAA2298F3AAB38625D5"
SECRET="hzZPb21La2YiERrT0qvcpuJR6m1mMaRd9dx66qrB"

AWS_PATH=$HOME/.aws


if [ ! -f /usr/local/bin/aws ]; then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm awscliv2.zip
    rm -rf aws
fi

# keys on https://console.filebase.com/keys

# configure

mkdir -p $AWS_PATH

echo "[default]
aws_access_key_id =  ${KEY} 
aws_secret_access_key = ${SECRET}
" > $AWS_PATH/credentials

echo "[default]
region = us-east-1
output = json
" > $AWS_PATH/config

# aws --endpoint https://s3.filebase.com s3 ls
