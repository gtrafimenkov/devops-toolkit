// SPDX-License-Identifier: MIT
// Copyright (c) 2019 Gennady Trafimenkov

data "aws_ami" "u1804-latest" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/*ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  owners = ["099720109477"]
}
