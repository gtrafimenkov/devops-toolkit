// SPDX-License-Identifier: MIT
// Copyright (c) 2019 Gennady Trafimenkov

variable "region" {
  description = "AWS region."
  type        = "string"
}

variable "tags" {
  description = "Set of tags to apply to every resource."
  type        = "map"
  default     = {}
}

variable "main-ssh-key" {
  description = "SSH key to be used for all instances."
  type        = "string"
  default     = "main-key"
}
