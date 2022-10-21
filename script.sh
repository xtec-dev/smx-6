#!/bin/bash

shopt -s extglob
rm -rf !("script.sh | uf*")

mkdir david
wget -q https://ca.wikipedia.org/wiki/Girona -P david
wget -q https://ca.wikipedia.org/wiki/Barcelona -P david
wget -q https://ca.wikipedia.org/wiki/Tarragona -P david

tar cf david.tar david
