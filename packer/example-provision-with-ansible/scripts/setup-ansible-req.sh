#!/bin/bash
#
# Setup packages required by ansible.

set -e

sudo apt-get update
sudo apt-get install -y python
