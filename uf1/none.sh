#!/bin/bash

# network: none

docker run \
  --name test-none \
  --network none \
  --mount type=bind,src="$(pwd)"/salvador.sh,dst=/salvador.sh,readonly=true \
  alpine/curl:3.14 sh salvador.sh

docker diff test-none

docker rm -vf test-none

# network-bridge

docker run \
  --name test-bridge \
  --mount type=bind,src="$(pwd)"/salvador.sh,dst=/salvador.sh,readonly=true \
  alpine/curl:3.14 sh salvador.sh

docker diff test-bridge

docker rm -vf test-bridge

docker run -it\
  --rm \
  --mount type=bind,src="$(pwd)"/salvador.sh,dst=/salvador.sh,readonly=true \
  alpine/curl:3.14 sh
