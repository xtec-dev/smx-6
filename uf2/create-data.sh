#!/bin/bash
mkdir -p /tmp/data

for ((i = 1; i <= 100; ++i)); do
  echo "a lot of data: $RANDOM" > "/tmp/data/data-$i.txt"
done


