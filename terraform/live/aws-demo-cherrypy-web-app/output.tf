// SPDX-License-Identifier: MIT
// Copyright (c) 2019 Gennady Trafimenkov

output "webapp_public_ip" {
  value = "${aws_instance.webapp.public_ip}"
}
