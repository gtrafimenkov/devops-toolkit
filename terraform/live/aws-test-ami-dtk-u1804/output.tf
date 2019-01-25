// SPDX-License-Identifier: MIT
// Copyright (c) 2019 Gennady Trafimenkov

output "public_ip" {
  value = "${aws_instance.u1804-test.public_ip}"
}
