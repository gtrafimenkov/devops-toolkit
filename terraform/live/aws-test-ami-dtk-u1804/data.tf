// SPDX-License-Identifier: MIT
// Copyright (c) 2019 Gennady Trafimenkov

data "aws_ami" "dtk-u1804-latest" {
  most_recent = true

  filter {
    name   = "name"
    values = ["dtk-u1804-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["self"]
}
