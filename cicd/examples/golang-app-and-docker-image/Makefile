# SPDX-License-Identifier: MIT
# Copyright (c) 2019 Gennady Trafimenkov

build:
	docker build -f Dockerfile.builder . -t build-golang-app
	mkdir -p output
	docker create --name tmp-cont build-golang-app
	docker cp tmp-cont:/bin/app output/app
	docker rm tmp-cont
	docker images | grep build-golang-app
	ls -l output

test:
	docker run --rm -t build-golang-app
	./output/app
