#!/bin/bash

SD=$(dirname $0)

for f in $(find $SD/../docs -type f -name '*.md'); do
    markdown-toc --min 2 $f
done
