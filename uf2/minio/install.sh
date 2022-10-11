#!/bin/bash

if [ ! -f /usr/local/bin/mc ]; then
    wget https://dl.min.io/client/mc/release/linux-amd64/mc
    chmod +x mc
    sudo mv mc /usr/local/bin
fi

mc alias set local http://127.0.0.1:9000 admin password
