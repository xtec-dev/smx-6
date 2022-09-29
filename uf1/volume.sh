#!/bin/bash

docker volume create \
  --driver local \
  salvador_espriu

docker volume inspect \
  --format "{{json .Mountpoint}}" \
  salvador_espriu