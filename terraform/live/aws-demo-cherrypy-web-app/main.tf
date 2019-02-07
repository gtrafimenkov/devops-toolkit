// SPDX-License-Identifier: MIT
// Copyright (c) 2019 Gennady Trafimenkov

provider "aws" {
  region = "${var.region}"
}

/////////////////////////////////////////////////////////////////////
// Networking
/////////////////////////////////////////////////////////////////////

resource "aws_vpc" "main" {
  cidr_block                 = "10.11.0.0/16"
  tags                       = "${merge(var.tags, map("Name", "main"))}"
}

resource "aws_internet_gateway" "main-igw" {
  vpc_id                     = "${aws_vpc.main.id}"
  tags                       = "${merge(var.tags, map("Name", "main-igw"))}"
}

resource "aws_subnet" "public" {
  vpc_id                     = "${aws_vpc.main.id}"
  cidr_block                 = "10.11.1.0/24"
  map_public_ip_on_launch    = true
  tags                       = "${merge(var.tags, map("Name", "public"))}"
}

resource "aws_route_table" "public-rt" {
  vpc_id                     = "${aws_vpc.main.id}"
  tags                       = "${merge(var.tags, map("Name", "public-rt"))}"
}

resource "aws_route_table_association" "public-rta" {
  subnet_id                  = "${aws_subnet.public.id}"
  route_table_id             = "${aws_route_table.public-rt.id}"
}

resource "aws_route" "public-route-to-igw" {
  route_table_id             = "${aws_route_table.public-rt.id}"
  destination_cidr_block     = "0.0.0.0/0"
  gateway_id                 = "${aws_internet_gateway.main-igw.id}"
}

resource "aws_security_group" "http" {
  name                       = "http"
  description                = "Allow inbound HTTP"
  vpc_id                     = "${aws_vpc.main.id}"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags                       = "${merge(var.tags, map("Name", "http"))}"
}

resource "aws_security_group" "ssh" {
  name                       = "ssh"
  description                = "Allow inbound SSH"
  vpc_id                     = "${aws_vpc.main.id}"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags                       = "${merge(var.tags, map("Name", "allow-ssh"))}"
}

resource "aws_security_group" "all-outbound" {
  name                       = "all-outbound"
  description                = "Allow all outbound traffic"
  vpc_id                     = "${aws_vpc.main.id}"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags                       = "${merge(var.tags, map("Name", "all-outbound"))}"
}

/////////////////////////////////////////////////////////////////////
// Compute
/////////////////////////////////////////////////////////////////////

resource "aws_instance" "webapp" {
    ami                      = "${data.aws_ami.u1804-latest.image_id}"
    instance_type            = "t2.micro"
    key_name                 = "${var.main-ssh-key}"
    subnet_id                = "${aws_subnet.public.id}"
    security_groups          = [
      "${aws_security_group.ssh.id}",
      "${aws_security_group.http.id}",
      "${aws_security_group.all-outbound.id}",
    ]
    user_data                = <<USERDATA
#!/bin/bash
apt-get update
apt-get upgrade -y
apt-get install -y docker.io
docker run -d --restart=always -p 80:9090 quay.io/gtrafimenkov/demos:cherrypy python3 /server.py
USERDATA
    tags                     = "${merge(var.tags, map("Name", "test01"))}"
}

/////////////////////////////////////////////////////////////////////
//
/////////////////////////////////////////////////////////////////////
