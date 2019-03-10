// SPDX-License-Identifier: MIT
// Copyright (c) 2019 Gennady Trafimenkov

/////////////////////////////////////////////////////////////////////
// Variables
/////////////////////////////////////////////////////////////////////

variable "region" {
  description = "AWS region."
  type        = "string"
  default     = "us-east-1"
}

variable "tags" {
  description = "Set of tags to apply to every resource."
  type        = "map"
  default     = {
    Project = "simple-instance"
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
    key    = "dtk/aws-demo-simple-instance"
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

resource "aws_security_group" "ssh" {
  name                       = "ssh"
  description                = "Allow inbound SSH"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags                       = "${merge(var.tags, map("Name", "allow-ssh"))}"
}

/////////////////////////////////////////////////////////////////////
// Compute
//
// simple01 - standard t2.micro instance
// simple02 - t2.micro with big root volume
// simple03 - t2.micro with additional persistent volume mounted
/////////////////////////////////////////////////////////////////////

resource "aws_instance" "simple01" {
    ami                      = "${data.aws_ami.u1804-latest.image_id}"
    instance_type            = "t2.micro"
    security_groups          = [
      "default",
      "${aws_security_group.ssh.name}",
    ]

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
    tags                     = "${merge(var.tags, map("Name", "simple01"))}"
}

// Instance with a big root device
resource "aws_instance" "simple02" {
    ami                      = "${data.aws_ami.u1804-latest.image_id}"
    instance_type            = "t2.micro"
    security_groups          = [
      "default",
      "${aws_security_group.ssh.name}",
    ]

    root_block_device = {
        volume_type = "gp2"
        volume_size = "20"
        delete_on_termination = "true"
    }

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
    tags                     = "${merge(var.tags, map("Name", "simple01"))}"
}

resource "aws_ebs_volume" "persistent03" {
    availability_zone        = "us-east-1a"
    size                     = 20
    encrypted                = true
    tags                     = "${merge(var.tags, map("Name", "persistent03"))}"
}

resource "aws_volume_attachment" "simple03_persistent03" {
  device_name                = "/dev/xvdh"
  volume_id                  = "${aws_ebs_volume.persistent03.id}"
  instance_id                = "${aws_instance.simple03.id}"
}

resource "aws_instance" "simple03" {
    ami                      = "${data.aws_ami.u1804-latest.image_id}"
    instance_type            = "t2.micro"

    availability_zone        = "us-east-1a"

    security_groups          = [
      "default",
      "${aws_security_group.ssh.name}",
    ]

    user_data                = <<USERDATA
#cloud-config
package_update: true
package_upgrade: true
packages:
  - htop
bootcmd:
  - 'blkid -p -n ext3 /dev/xvdh || mkfs.ext3 -f /dev/xvdh'
  - 'mkdir -p /data/persistent'
mounts:
  - [ /dev/xvdh, /data/persistent, "ext3", "rw", "0", "0" ]
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
    tags                     = "${merge(var.tags, map("Name", "simple03"))}"
}

/////////////////////////////////////////////////////////////////////
// Output
/////////////////////////////////////////////////////////////////////

output "simple01_public_ip" {
  value = "${aws_instance.simple01.public_ip}"
}

output "simple02_public_ip" {
  value = "${aws_instance.simple02.public_ip}"
}

output "simple03_public_ip" {
  value = "${aws_instance.simple03.public_ip}"
}
