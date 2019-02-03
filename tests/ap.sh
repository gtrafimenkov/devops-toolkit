#!/bin/bash

SD=$(dirname $0)

CONFIG=$SD/ansible.cfg
INVENTORY=$SD/ansible/inventory
LIBRARY=$SD/ansible/library

PLAY=$1

shift

export ANSIBLE_ROLES_PATH=$SD/../ansible-roles:$SD/ansible-roles-tp

ANSIBLE_CONFIG=$CONFIG ansible-playbook -i "$INVENTORY" -M "$LIBRARY" $PLAY $*
