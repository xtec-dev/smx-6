#!/bin/bash

echo "Work in Progress"

case $1 in
install)
    if [ ! -f /usr/bin/az ]; then
        curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
    fi

    if [ ! -f /usr/bin/azcopy ]; then

        wget https://aka.ms/downloadazcopy-v10-linux
        tar -xvf downloadazcopy-v10-linux

        chmod +x ./azcopy_linux_amd64_*/azcopy
        sudo mv ./azcopy_linux_amd64_*/azcopy /usr/bin/azcopy

        rm -f downloadazcopy-v10-linux
        rm -rf ./azcopy_linux_amd64_*/

    fi
    ;;

login)
    az login --tenant learn.docs.microsoft.com
    az configure --defaults group=$(az group list --query '[].name' --output tsv)
    ;;

*)
    echo "unkown command"
    ;;

esac

#azcopy make "https://.blob.core.windows.net/[top-level-resource-name]"
