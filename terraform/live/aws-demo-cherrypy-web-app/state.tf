// SPDX-License-Identifier: MIT
// Copyright (c) 2019 Gennady Trafimenkov

terraform {
  backend "s3" {
    bucket = "gt-tfstate"
    key    = "dtk/aws-demo-cherrypy-web-app"
    region = "eu-central-1"
  }
}
