#!/bin/bash

file="data-$(date '+%Y%m%d-%H%M%S').tar.gz"
tar czf $file data

#rm $file
