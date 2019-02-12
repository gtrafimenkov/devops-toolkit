// SPDX-License-Identifier: MIT
// Copyright (c) 2019 Gennady Trafimenkov

/////////////////////////////////////////////////////////////////////
// Variables
/////////////////////////////////////////////////////////////////////

variable "region" {
  description = "AWS region."
  type        = "string"
  default     = "eu-central-1"
}

variable "tags" {
  description = "Set of tags to apply to every resource."
  type        = "map"
  default     = {
    Project = "simple-bastion"
  }
}

variable "user" {
  description = "Name of the user to create."
  type        = "string"
  default     = "gtrafimenkov"
}

variable "user-ssh-key" {
  description = "SSH key of the user."
  type        = "string"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjguMn0RjJLbqAyKjWyxg4mdN4z4RPbesYOp8e99yiRjKVOaXCXnLY0+wEuoM+kSUgfwrmIyVlpAbWS7y+EEMRvmeRrXO6FvnsqOTEStwGH3+4nZjZ8LLuMOVGI5/VoMenwBGJ+9INuVJczwA30bQQTeDVJJkyTnRZOKZVvLr+Rl3H3v9q7b7zNBi2jQ+fUMv78BwaLuP/fS7VvhfJYeKogs6e6WZyim6L5T5RkamHmdlM1iKlUqq84FAlFM6vfPD6TkXZOZmaH6X0Y1wVQTMpUfJp3SSiVKj96OLiTQHU2g1n8M9imRe9+/MuyovqkyOyQ7xmMkoMxLlYKQyRsqH5"
}

/////////////////////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////////////////////

provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {
    bucket = "gt-tfstate"
    key    = "dtk/aws-demo-simple-bastion"
    region = "eu-central-1"
  }
}

/////////////////////////////////////////////////////////////////////
// Data
/////////////////////////////////////////////////////////////////////

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

/////////////////////////////////////////////////////////////////////
// Networking
/////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////
// Compute
/////////////////////////////////////////////////////////////////////

resource "aws_instance" "bastion" {
    ami                      = "${data.aws_ami.u1804-latest.image_id}"
    instance_type            = "t2.micro"
    user_data                = <<USERDATA
#cloud-config
package_update: true
package_upgrade: true
packages:
  - htop
users:
  - name: ${var.user}
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, admin
    shell: /bin/bash
    ssh_authorized_keys:
      - ${var.user-ssh-key}
runcmd:
  - deluser --remove-home ubuntu
USERDATA
    tags                     = "${merge(var.tags, map("Name", "bastion"))}"
}

/////////////////////////////////////////////////////////////////////
// Output
/////////////////////////////////////////////////////////////////////

output "bastion_public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}
