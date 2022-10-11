#!/bin/bash

# filebase.com

if [ ! -f /usr/local/bin/aws ]; then
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm awscliv2.zip
    rm -rf aws
fi

# keys on https://console.filebase.com/keys
# Region: us-east-1
# Output Format: Optional
aws configure