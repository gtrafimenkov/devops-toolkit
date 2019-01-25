#!/bin/bash

SD=$(dirname $0)

# ansible-roles
for f in $(find $SD/../ansible-roles -type f -name '*.yml' -print); do
    if ! grep -q "# SPDX" $f; then
        sed -i '1s!^!# SPDX-License-Identifier: MIT\n# Copyright (c) 2019 Gennady Trafimenkov\n\n!' $f
    fi
done

# terraform
for f in $(find $SD/../terraform -type f -name '*.tf' -print); do
    if ! grep -q "# SPDX" $f; then
        sed -i '1s!^!// SPDX-License-Identifier: MIT\n// Copyright (c) 2019 Gennady Trafimenkov\n\n!' $f
    fi
done
