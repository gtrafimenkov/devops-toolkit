#!/bin/bash

set -e

SD=$(dirname $0)

cd $SD/..

for dir in $(find ./ansible-roles -maxdepth 1 -type d -print); do
    if ! test -f $dir/LICENSE; then
        cp templates/LICENSE $dir
    fi
done

