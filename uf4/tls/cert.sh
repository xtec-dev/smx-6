#!/bin/bash

mkdir -p certs

openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout xtec.key -out xtec.crt
