#!/bin/bash

shopt -s extglob
rm -rf * !("script.sh")

mkdir david
wget -q https://ca.wikipedia.org/wiki/Girona -P david
wget -q https://ca.wikipedia.org/wiki/Barcelona -P david
wget -q https://ca.wikipedia.org/wiki/Tarragona -P david




