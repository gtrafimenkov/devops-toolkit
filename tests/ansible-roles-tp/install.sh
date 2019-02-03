#!/bin/bash

SD=$(dirname $0)

ansible-galaxy install -p $SD -r $SD/requirements.yml $*
