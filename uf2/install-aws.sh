#!/bin/bash


if [ ! -f /usr/local/bin/aws ]; then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm awscliv2.zip
    rm -rf aws
fi

# keys on https://console.filebase.com/keys
#aws configure

mkdir -p ~./aws
echo "[default]
region = us-east-1
output = Optional
" >> ~./aws/config

# aws --endpoint https://s3.filebase.com s3 ls
