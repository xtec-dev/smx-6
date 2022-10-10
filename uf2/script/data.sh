#!/bin/bash
mkdir -p data

for ((i = 1; i <= 20; ++i)); do
  echo "a lot of data: $RANDOM" > "data/data-$i.txt"
done


