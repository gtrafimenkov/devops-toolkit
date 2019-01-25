# SPDX-License-Identifier: MIT
# Copyright (c) 2019 Gennady Trafimenkov

FROM debian:sid-slim

RUN echo "==> Setup build dependencies..." \
  && echo 'deb-src http://deb.debian.org/debian sid main' >>/etc/apt/sources.list \
  && apt-get update \
  && apt-get build-dep linux -y \
  && apt-get install -y build-essential fakeroot wget sudo \
  && apt-get clean && rm -rf /var/lib/apt/lists/*
