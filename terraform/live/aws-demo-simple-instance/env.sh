# SPDX-License-Identifier: MIT
# Copyright (c) 2019 Gennady Trafimenkov

export AWS_PROFILE=aws2

alias tfi='terraform init'
alias tfp='terraform plan --out terraform-plan'
alias tfa='terraform apply terraform-plan'
alias tfd='terraform destroy'
