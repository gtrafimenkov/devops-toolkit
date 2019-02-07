#!/bin/bash

SD=$(dirname $0)

# docker
for f in $(find $SD/../docker-images -type f \( -name 'Dockerfile*' -o -name 'Makefile' \) -print); do
    if ! grep -q "# SPDX-License-Identifier" $f; then
        sed -i '1s!^!# SPDX-License-Identifier: MIT\n# Copyright (c) 2019 Gennady Trafimenkov\n\n!' $f
    fi
done

# ansible
for f in $(find $SD/../ansible-roles -type f -name '*.yml' -print); do
    if ! grep -q "# SPDX-License-Identifier" $f; then
        sed -i '1s!^!# SPDX-License-Identifier: MIT\n# Copyright (c) 2019 Gennady Trafimenkov\n\n!' $f
    fi
done
for f in $(find $SD/../tests/ansible -type f -name '*.yml' -print); do
    if ! grep -q "# SPDX-License-Identifier" $f; then
        sed -i '1s!^!# SPDX-License-Identifier: MIT\n# Copyright (c) 2019 Gennady Trafimenkov\n\n!' $f
    fi
done

# terraform
for f in $(find $SD/../terraform -type f \( -name '*.tf' -o -name '*.tfvars' \) -print); do
    if ! grep -q "// SPDX-License-Identifier" $f; then
        sed -i '1s!^!// SPDX-License-Identifier: MIT\n// Copyright (c) 2019 Gennady Trafimenkov\n\n!' $f
    fi
done
